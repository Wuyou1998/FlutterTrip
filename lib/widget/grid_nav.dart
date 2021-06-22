import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xiecheng_demo/model/grid_nav_module.dart';
import 'package:xiecheng_demo/model/local_nav_list_module.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';

class GridNavView extends StatelessWidget {
  final GridNav gridNav;

  const GridNavView({Key key, @required this.gridNav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.hotel != null) {
      items.add(_gridNavItem(context, gridNav.hotel, true));
    }
    if (gridNav.flight != null) {
      items.add(_gridNavItem(context, gridNav.flight, false));
    }
    if (gridNav.travel != null) {
      items.add(_gridNavItem(context, gridNav.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> items = [];
    List<Widget> expandItems = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, LocalNavListItem commonItem) {
    return _warpGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image.network(
              commonItem.icon,
              fit: BoxFit.contain,
              width: 88,
              height: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                commonItem.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        commonItem);
  }

  _doubleItem(BuildContext context, LocalNavListItem topItem,
      LocalNavListItem bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(
    BuildContext context,
    LocalNavListItem item,
    bool isFirst,
  ) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: isFirst ? borderSide : BorderSide.none),
        ),
        child: _warpGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  _warpGesture(
      BuildContext context, Widget widget, LocalNavListItem commonItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewWidget(
                      url: commonItem.url,
                      statusBarColor: commonItem.statusBarColor,
                      title: commonItem.title,
                      hideAppBar: false,
                    )));
      },
      child: widget,
    );
  }
}
