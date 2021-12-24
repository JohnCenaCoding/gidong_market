import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "기동 마켓",
            style: TextStyle(color: Colors.black),
          ),
          ExtendedImage.asset("assets/images/carrot_intro.png")
        ],
      ),
    );
  }
}
