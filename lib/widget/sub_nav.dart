import 'package:flutter/material.dart';
import 'package:xiecheng_demo/model/sub_nav_list_module.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';

class SubNav extends StatelessWidget {
  final List<SubNavListItem> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //Container这个东西有了decoration后就不能设置color了，不然报错
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    if (subNavList == null) return null;
    subNavList.forEach((item) {
      items.add(_item(context, item));
    });
    //计算出第一行显示的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    //总是将数据分成上下两行来显示
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, SubNavListItem subNavListItem) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print(subNavListItem.url);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewWidget(
                        url: subNavListItem.url,
                        title: subNavListItem.title,
                        hideAppBar: subNavListItem.hideAppBar,
                      )));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              subNavListItem.icon,
              width: 18,
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                subNavListItem.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
