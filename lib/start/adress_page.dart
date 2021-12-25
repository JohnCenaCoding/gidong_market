import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/utils/logger.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
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
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(10, 48),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return ListTile(
                  //제일 왼족에 넣는 것 leading
                  //제일 오른쪽에 넣는 것 trailing
                  title: Text('address: $index'),
                  subtitle: Text('address: $index'),
                );
              },
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }
}
