import 'package:flutter/material.dart';
import 'package:xiecheng_demo/modle/local_nav_list_module.dart';
import 'package:xiecheng_demo/widget/web_view.dart';

class LocalNav extends StatelessWidget {
  final List<LocalNavListItem> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('列表长度:${localNavList.length}');
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList.isEmpty) return null;
    List<Widget> _itemList = [];
    localNavList.forEach((localNav) {
      _itemList.add(_item(context, localNav));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _itemList,
    );
  }

  Widget _item(BuildContext context, LocalNavListItem localNav) {
    return GestureDetector(
      onTap: () {
        print(localNav.url);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: localNav.url,
                      statusBarColor: localNav.statusBarColor,
                      title: localNav.title,
                      hideAppBar: localNav.hideAppBar,
                    )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            localNav.icon,
            width: 36,
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              localNav.title,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
