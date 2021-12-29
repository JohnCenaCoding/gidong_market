import 'package:flutter/material.dart';
import 'package:gidong_market/start/adress_page.dart';
import 'package:gidong_market/start/auth_page.dart';
import 'package:gidong_market/start/intro_page.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //pagecontroller를 다른 페이지에서도 접근하게 하기 위해 Provider 사용
    //일반적으로 Provider를 사용하는 이유가 provider안에 전달을 해주는 데이터가 변경이 될 때 그 변경 사항에 따라서 각 하위 위젯들의 모양을 바꿔주기 위해 사용 하는데,
    //여기Provider안에 pageController자체는 변경 될 것이 없다.pageController를 가지고 내용을 바꾸는 게 아니라 사용만 하는 것 이기 때문에
    // pagecontroller가 라우트 숫자를 바꿔주는 걸 알아서 하는 거지 PageController object자체는 변경 되는 게 없다.
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        body: PageView(
          //scroll막기
          // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            IntroPage(),
            AddressPage(),
            AuthPage(),
          ],
        ),
      ),
    );
  }
}
