import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gidong_market/constants/common_size.dart';
import 'package:gidong_market/states/user_provider.dart';
import 'package:gidong_market/utils/logger.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phonNumberController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStauts _verificationStauts = VerificationStauts.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        //IgnoerPointer가 true면 모든 입력 무시.
        return IgnorePointer(
          ignoring: _verificationStauts == VerificationStauts.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "전화번호 로그인",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(common_padding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ExtendedImage.asset(
                              'assets/images/padlock.png',
                              width: size.width * 0.15,
                              height: size.height * 0.15,
                            ),
                            SizedBox(width: common_sm_padding),
                            Text(
                                '기동 마켓은 휴대폰 번호로 가입해요.\n 번호는 안전하게 보관 되며\n어디에도 공개되지 않아요.'),
                          ],
                        ),
                        SizedBox(height: common_padding),
                        TextFormField(
                          controller: _phonNumberController,
                          inputFormatters: [
                            //maked란 입력 룰을 정해주는 부분
                            MaskedInputFormatter("000 0000 0000"),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            focusedBorder: inputBorder,
                            border: inputBorder,
                          ),
                          validator: (phoneNumeber) {
                            if (phoneNumeber != null &&
                                phoneNumeber.length == 13) {
                              //return으로 null을 주면 에러가 없다고 인식한다.
                              return null;
                            } else {
                              return "전화번호 똑바로 입력해줄래?";
                            }
                          },
                        ),
                        SizedBox(height: common_sm_padding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextButton(
                              onPressed: () {
                                // _getAddress();
                                if (_formKey.currentState != null) {
                                  bool passed =
                                      _formKey.currentState!.validate();
                                  print(passed);
                                  if (passed)
                                    setState(() {
                                      _verificationStauts =
                                          VerificationStauts.codeSent;
                                    });
                                }
                              },
                              child: Text(
                                "인증문자 발송",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: common_padding),
                        AnimatedOpacity(
                          //_verificationStatus가 none: 0 아닐경우는 1
                          opacity:
                              (_verificationStauts == VerificationStauts.none)
                                  ? 0
                                  : 1,
                          duration: duration,
                          curve: Curves.easeInOut,
                          child: AnimatedContainer(
                            height: getVerificationHeight(_verificationStauts),
                            duration: duration,
                            curve: Curves.easeInOut,
                            child: TextFormField(
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskedInputFormatter("000000"),
                              ],
                              decoration: InputDecoration(
                                focusedBorder: inputBorder,
                                border: inputBorder,
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: duration,
                          curve: Curves.easeInOut,
                          height: getVerificationBtnHeight(_verificationStauts),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextButton(
                                onPressed: () {
                                  attemptVerify();
                                },
                                child: (_verificationStauts ==
                                        VerificationStauts.verifying)
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        "인증",
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStauts stauts) {
    switch (stauts) {
      case VerificationStauts.none:
        return 0;
      case VerificationStauts.codeSent:
      case VerificationStauts.verifying:
      case VerificationStauts.verificationDone:
        return 60 + common_sm_padding;
    }
  }

  double getVerificationBtnHeight(VerificationStauts stauts) {
    switch (stauts) {
      case VerificationStauts.none:
        return 0;
      case VerificationStauts.codeSent:
      case VerificationStauts.verifying:
      case VerificationStauts.verificationDone:
        return 48 + common_sm_padding;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStauts = VerificationStauts.verifying;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      VerificationStauts.verificationDone;
    });

    //notify 해주는 함수를 부를 때는 무조건 read로 해줘야 한다. 안그러면 무한 루프를 돌게 된다.
    context.read<UserProvider>().setUserAuth(true);
  }

  _getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address') ?? "";
    loggar.d('Address from shared pref - $address');
  }
}

enum VerificationStauts { none, codeSent, verifying, verificationDone }
