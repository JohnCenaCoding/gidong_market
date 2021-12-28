import 'package:dio/dio.dart';
import 'package:gidong_market/constants/keys.dart';
import 'package:gidong_market/data/address_model.dart';
import 'package:gidong_market/utils/logger.dart';

class AddressService {
  Future<AddressModel> searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
      'size': 30,
    };

    //queryparameter를 쓰면 알아서 josn(key:value)형태와 끝에 & 까지 알아서 입력해줘서 편하게 서버에 요청 할 수 있다.
    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      loggar.e(e.message);
    });

    //api에서 받아온 데이터는 response.data에 저장된다.
    //dio에서 알아서 json형식으로 데이터가 왔을 때 Map 형태로 바꿔준다. 우리는 이걸 dart object로 만들어 줘서 flutter widget에서 사용해야 한다.
    // loggar.d(response.data is Map);
    // loggar.d(response.data['response']['result']);

    AddressModel addressModel =
        AddressModel.fromJson(response.data['response']);
    loggar.d(addressModel);
    return addressModel;
  }
}
