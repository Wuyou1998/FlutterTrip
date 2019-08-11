import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewWidget extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  //默认阻止回到h5主页，但是如果是 我的 页面，就允许退回
  final bool isMyPage;

  WebViewWidget(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false,
      this.isMyPage = false})
      : super(key: key) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  _isToMain(String url) {
    bool containThisUrl = false;
    if (widget.isMyPage) return containThisUrl;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) containThisUrl = true;
    }
    return containThisUrl;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff')
      backButtonColor = Colors.black;
    else
      backButtonColor = Colors.white;
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                if (_isToMain(request.url)) {
                  Navigator.pop(context);
                  Toast.show('除了我的页面的webView，其他的返回h5页面的请求均会关闭当前页面', context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backGroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backGroundColor,
        height: 28,
      );
    }
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
