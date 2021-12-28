import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  //글로벌로 선언하면 notifyListenrners를 안거치고 막 변경할 수 있으니까 private로 선언.
  bool _userLoggedIN = false;

  void setUserAuth(bool authState) {
    _userLoggedIN = authState;
    notifyListeners();
  }

  //현재 userState가 변경 됐는지 안됐는지를 알 수 있게 하도록 get 설정
  //get으로는 변경이 안되니까 데이터를 확인하는 용도로만 쓸 수 있게 막아주는 역할도 함.
  bool get userState => _userLoggedIN;
}
