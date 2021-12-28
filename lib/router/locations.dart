import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:gidong_market/screens/home_screen.dart';

class HomeLacation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  //이부분은 웹사이트의 주소 처럼 각각 라우트들도 주소를 가지고 있는데 그 주소를 알려주는 부분이이다.
  // 여기서는 이 부분이 홈페이지다 라고 알려주고 있다.
  List<Pattern> get pathPatterns => ['/'];
}
