import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_demo/dao/home_dao.dart';
import 'package:xiecheng_demo/modle/banner_list_module.dart';
import 'package:xiecheng_demo/modle/grid_nav_module.dart';
import 'package:xiecheng_demo/modle/home_module.dart';
import 'package:xiecheng_demo/modle/local_nav_list_module.dart';
import 'package:xiecheng_demo/modle/sales_box_module.dart';
import 'package:xiecheng_demo/modle/sub_nav_list_module.dart';
import 'package:xiecheng_demo/widget/grid_nav.dart';
import 'package:xiecheng_demo/widget/local_nav.dart';
import 'package:xiecheng_demo/widget/sales_box.dart';
import 'package:xiecheng_demo/widget/sub_nav.dart';
import 'package:xiecheng_demo/widget/web_view.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0;
  List<BannerListModule> _bannerList = [];
  List<LocalNavListItem> _localNavList = [];
  List<SubNavListItem> _subNavList = [];
  GridNav _gridNav;
  SalesBoxModel _salesBoxModel;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) alpha = 0;
    if (alpha > 1) alpha = 1;
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  _loadData() async {
    try {
      HomeModule homeModule = await HomeDao.fetch();
      setState(() {
        _bannerList = homeModule.bannerList;
        _localNavList = homeModule.localNavList;
        _subNavList = homeModule.subNavList;
        _gridNav = homeModule.gridNav;
        _salesBoxModel = homeModule.salesBoxModel;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  //列表滚动时
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  _Swiper,
                  _LocalList,
                  _GridList,
                  _SubList,
                  _SalesBox,
                ],
              ),
            ),
          ),
          _AppBar,
        ],
      ),
    );
  }

  Widget get _Swiper {
    return Container(
      height: 240,
      child: Swiper(
        itemCount: _bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                            url: _bannerList[index].url,
                          )));
            },
            child: Image.network(
              _bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: SwiperPagination.fraction),
      ),
    );
  }

  Widget get _LocalList {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: LocalNav(
          localNavList: _localNavList,
        ),
      ),
    );
  }

  Widget get _GridList {
    return GridNavView(
      gridNav: _gridNav,
    );
  }

  Widget get _SubList {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: SubNav(
          subNavList: _subNavList,
        ),
      ),
    );
  }

  Widget get _SalesBox {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
        child: SalesBox(
          salesBoxModel: _salesBoxModel,
        ),
      ),
    );
  }

  Widget get _AppBar {
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }
}
