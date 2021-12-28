import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/router/locations.dart';
import 'package:gidong_market/screens/start_screen.dart';
import 'package:gidong_market/screens/splash_screen.dart';
import 'package:gidong_market/states/user_provider.dart';
import 'package:gidong_market/utils/logger.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final _routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
        pathPatterns: ['/'],
        check: (context, location) {
          //read일때는 notify를 안받지만 watch로 해주면 notify를 받을 수 있다.
          return context.watch<UserProvider>().userState;
        },
        showPage: BeamPage(
          child: StartScreen(),
        ),
      ),
    ],
    //beamLocations는 beamer에게 모든 locator를 맡기는데 맡기면서 어떤 화면을 맡기는지 beamer에게 알려줘야 한다.
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLacation()]));

void main() {
  HttpOverrides.global = MyHttpOverrides();

  loggar.d("My first log by loggar");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //원래는 <Object> 자리에 받아와야 할 값의 타입을 적어 놓는다. 예를들면 string이다 하면 <String>이런식으로
    return FutureBuilder<Object>(
      future: Future.delayed(Duration(milliseconds: 300), () => 100),
      //future가 snapshot에 저장이 됌
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: splashLoadingWidget(snapshot));
      },
    );
  }

  StatelessWidget splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print("error compile while loading");
      return Text("Error occur");
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'DoHyeon',
          hintColor: Colors.grey[350],
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              primary: Colors.white,
              minimumSize: Size(48, 48),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black87),
            elevation: 2,
            actionsIconTheme: IconThemeData(color: Colors.black87),
          ),
          //전체 텍스트 버튼에 스타일 입히기
        ),
        //beamer가 알아서 route 주소를 읽어서 사용자에게 어떤 스크린을 보여줄지 정하는 것
        routeInformationParser: BeamerParser(),
        //routerDelegate : beamer에게 여기로 보내줘 하면 알아서 가게끔 하는 것
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
