import 'package:flutter/material.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';


const String MY_URL = 'https://m.ctrip.com/webapp/myctrip/';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      url: MY_URL,
      hideAppBar: true,
      backForbid: true,
      statusBarColor: '4c5bca',
      isMyPage: true,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
