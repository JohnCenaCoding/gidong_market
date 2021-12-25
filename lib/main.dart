import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/router/locations.dart';
import 'package:gidong_market/screens/auth_screen.dart';
import 'package:gidong_market/screens/splash_screen.dart';
import 'package:gidong_market/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
        pathPatterns: ['/'],
        check: (context, location) {
          return false;
        },
        showPage: BeamPage(
          child: AuthScreen(),
        ),
      ),
    ],
    //beamLocations는 beamer에게 모든 locator를 맡기는데 맡기면서 어떤 화면을 맡기는지 beamer에게 알려줘야 한다.
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLacation()]));

void main() {
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
    return MaterialApp.router(
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'DoHyeon',
          hintColor: Colors.grey[300],
          textTheme: TextTheme(
              headline3: TextStyle(fontFamily: 'DoHyeon'),
              button: TextStyle(color: Colors.white))),
      //beamer가 알아서 route 주소를 읽어서 사용자에게 어떤 스크린을 보여줄지 정하는 것
      routeInformationParser: BeamerParser(),
      //routerDelegate : beamer에게 여기로 보내줘 하면 알아서 가게끔 하는 것
      routerDelegate: _routerDelegate,
    );
  }
}
