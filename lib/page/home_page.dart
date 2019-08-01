import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_demo/dao/home_dao.dart';
import 'package:xiecheng_demo/modle/home_module.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _list = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564399444243&di=00ede8c0b4aa7b1a4b49ea18f96116ae&imgtype=0&src=http%3A%2F%2Farticle.fd.zol-img.com.cn%2Ft_s640x2000%2Fg5%2FM00%2F0C%2F02%2FChMkJln2k0qIBkAxAACMisBGyasAAhrdgBndFAAAIyi245.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564399486619&di=9eacee1feed84f09f4f8c6e967064cb1&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201905%2F12%2F121633dobk1qmlhxho020j.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564399522982&di=6a0a54097279b8c932dde5877eff37eb&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F2e2eb9389b504fc2bbdd8ce9ebdde71191ef6d5f.jpg',
    'https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=93cc863af81fbe09035ec5145b600c30/00e93901213fb80e93ebd89b3cd12f2eb9389440.jpg',
  ];
  double _appBarAlpha = 0;
  String resultString = '';

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0)
      alpha = 0;
    if (alpha > 1)
      alpha = 1;
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  _loadData() async {
    HomeDao.fetch().then((result) {
      setState(() {
        resultString = json.encode(result);
      });
    }).catchError((e) {
      setState(() {
        resultString = e.toString();
      });
    });
//    try {
      HomeModule homeModule = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(homeModule);
        print(homeModule.bannerList[0].url);
      });
//    } catch (e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    height: 240,
                    child: Swiper(
                      itemCount: _list.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _list[index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomRight,
                          builder: SwiperPagination.fraction
                      ),
                    ),
                  ),
                  Container(
                    height: 800,
                    color: Colors.amber,
                    child: Text(resultString),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),);
  }
}
