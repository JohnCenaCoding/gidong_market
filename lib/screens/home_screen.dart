import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gidong_market/screens/home/items_page.dart';
import 'package:gidong_market/states/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _bottomSelectedIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          ItemsPage(),
          Container(
            color: Colors.accents[0],
          ),
          Container(
            color: Colors.accents[1],
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[3],
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '서산시',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.nosign),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.text_justify),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(_bottomSelectedIndex == 0
                ? AssetImage('assets/images/selected_home.png')
                : AssetImage('assets/images/home.png')),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(_bottomSelectedIndex == 1
                ? AssetImage('assets/images/selected_placeholder.png')
                : AssetImage('assets/images/placeholder.png')),
            label: "내 근처",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(_bottomSelectedIndex == 2
                ? AssetImage('assets/images/selected_smartphone.png')
                : AssetImage('assets/images/smartphone.png')),
            label: "채팅",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(_bottomSelectedIndex == 3
                ? AssetImage('assets/images/selected_user.png')
                : AssetImage('assets/images/user.png')),
            label: "내정보",
          ),
        ],
      ),
    );
  }
}
