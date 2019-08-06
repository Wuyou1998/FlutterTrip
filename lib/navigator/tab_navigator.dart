import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiecheng_demo/dao/home_dao.dart';
import 'package:xiecheng_demo/modle/home_module.dart';
import 'package:xiecheng_demo/page/home_page.dart';
import 'package:xiecheng_demo/page/my_page.dart';
import 'package:xiecheng_demo/page/search_page.dart';
import 'package:xiecheng_demo/page/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final defaultColor = Colors.grey;
  final activeColor = Colors.blueAccent;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: activeColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex == 0 ? activeColor : defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: defaultColor,
              ),
              activeIcon: Icon(
                Icons.search,
                color: activeColor,
              ),
              title: Text(
                '搜索',
                style: TextStyle(
                    color: _currentIndex == 1 ? activeColor : defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                color: defaultColor,
              ),
              activeIcon: Icon(
                Icons.camera,
                color: activeColor,
              ),
              title: Text(
                '旅拍',
                style: TextStyle(
                    color: _currentIndex == 2 ? activeColor : defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                color: defaultColor,
              ),
              activeIcon: Icon(
                Icons.account_box,
                color: activeColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(
                    color: _currentIndex == 3 ? activeColor : defaultColor),
              )),
        ],
      ),
    );
  }
}
