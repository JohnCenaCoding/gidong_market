import 'package:flutter/material.dart';
import 'package:gidong_market/start/adress_page.dart';
import 'package:gidong_market/start/intro_page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //scroll막기
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          IntroPage(_pageController),
          AddressPage(),
          Container(
            color: Colors.accents[5],
          ),
        ],
      ),
    );
  }
}
