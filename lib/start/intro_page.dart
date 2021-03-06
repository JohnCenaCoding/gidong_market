import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/utils/logger.dart';

class IntroPage extends StatelessWidget {
  PageController controller;
  IntroPage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //화면사이즈가 바뀔 때 마다 layoutbuilder가 각각의 위젯을 다시 리빌드를 해준다.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        //좌우 패딩이 16 이니까 더해서 32
        final imgSize = size.width - 32;

        final sizeOfPosImg = imgSize * 0.1;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "기동 마켓",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: Stack(
                    children: [
                      //Stack은 코드가 아래쪽으로 갈 수록 화면 위에 자리 잡는다.
                      ExtendedImage.asset("assets/images/carrot_intro.png"),
                      Positioned(
                          width: sizeOfPosImg,
                          height: sizeOfPosImg,
                          left: imgSize * 0.45,
                          top: imgSize * 0.45,
                          child: ExtendedImage.asset(
                              "assets/images/carrot_intro_pos.png")),
                    ],
                  ),
                ),
                Text("우리 부대 공구 장터 기동마켓",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(
                  "기동 마켓은 우리부대 공동구매 시장이에요.\n"
                  "부대원 임을 증명하고 시작해보세요!",
                  style: TextStyle(fontSize: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: onButtonClick,
                      child: Text(
                        "부대원 증명하고 시작하기",
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onButtonClick() {
    controller.animateToPage(
      1,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    loggar.d('on text BUtton clicked!!');
  }
}
