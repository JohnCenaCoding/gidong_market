import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/constants/common_size.dart';
import 'package:gidong_market/data/address_model.dart';
import 'package:gidong_market/start/address_service.dart';
import 'package:gidong_market/utils/logger.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        left: common_padding,
        right: common_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _addressController,
            onFieldSubmitted: (text) async {
              _addressModel = await AddressService().searchAddressByStr(text);
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: "도로명으로 검색",
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24, minHeight: 24)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(CupertinoIcons.compass, color: Colors.white, size: 20),
            label: Text(
              "현재 위치로 찾기",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: common_padding),
              itemBuilder: (context, index) {
                if (_addressModel! == null ||
                    _addressModel!.result == null ||
                    _addressModel!.result!.items! == null ||
                    _addressModel!.result!.items![index].address == null)
                  return Container();
                return ListTile(
                  //제일 왼족에 넣는 것 leading
                  //제일 오른쪽에 넣는 것 trailing

                  title: Text(
                      _addressModel!.result!.items![index].address!.road ?? ""),
                  subtitle: Text(
                      _addressModel!.result!.items![index].address!.parcel ??
                          ""),
                );
              },
              itemCount: _addressModel == null
                  ? 0
                  : (_addressModel! == null ||
                          _addressModel!.result == null ||
                          _addressModel!.result!.items! == null)
                      ? 0
                      : _addressModel!.result!.items!.length,
            ),
          )
        ],
      ),
    );
  }
}
