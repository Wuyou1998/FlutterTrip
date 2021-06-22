import 'package:flutter/material.dart';
import 'package:xiecheng_demo/model/local_nav_list_module.dart';
import 'package:xiecheng_demo/model/sales_box_module.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';

//底部卡片入口
class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key key, this.salesBoxModel}) : super(key: key);

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
    if (salesBoxModel == null) return null;
    items.add(_doubleItem(
        context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
    items.add(_doubleItem(context, salesBoxModel.smallCard1,
        salesBoxModel.smallCard2, false, false));
    items.add(_doubleItem(context, salesBoxModel.smallCard3,
        salesBoxModel.smallCard4, false, true));
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                salesBoxModel.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewWidget(
                                  url: salesBoxModel.moreUrl,
                                  title: '更多活动',
                                )));
                  },
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, LocalNavListItem leftItem,
      LocalNavListItem rightItem, bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftItem, isBig,true, isLast),
        _item(context, rightItem, isBig,false, isLast),
      ],
    );
  }

  Widget _item(BuildContext context, LocalNavListItem item, bool isBig,
      bool isLeft, bool isLast) {
    BorderSide borderSide=BorderSide(width: 1,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        print(item.url);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewWidget(
                      url: item.url,
                      title: item.title,
                      hideAppBar: item.hideAppBar,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: isLeft?borderSide:BorderSide.none,bottom: isLast?BorderSide.none:borderSide)
        ),
        child: Image.network(
          item.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 20,
          height: isBig ? 129 : 80,
        ),
      ),
    );
  }
}
