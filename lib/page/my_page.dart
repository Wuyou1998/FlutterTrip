import 'package:flutter/material.dart';
import 'package:xiecheng_demo/widget/web_view.dart';

const String MY_URL = 'https://m.ctrip.com/webapp/myctrip/';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      url: MY_URL,
      hideAppBar: true,
      backForbid: true,
      statusBarColor: '4c5bca',
    );
  }
}
