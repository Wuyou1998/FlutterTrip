import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_demo/dao/home_dao.dart';
import 'package:xiecheng_demo/model/banner_list_module.dart';
import 'package:xiecheng_demo/model/grid_nav_module.dart';
import 'package:xiecheng_demo/model/home_module.dart';
import 'package:xiecheng_demo/model/local_nav_list_module.dart';
import 'package:xiecheng_demo/model/sales_box_module.dart';
import 'package:xiecheng_demo/model/sub_nav_list_module.dart';
import 'package:xiecheng_demo/page/city_page.dart';
import 'package:xiecheng_demo/page/search_page.dart';
import 'package:xiecheng_demo/page/speak_page.dart';
import 'package:xiecheng_demo/widget/grid_nav.dart';
import 'package:xiecheng_demo/widget/loading_container.dart';
import 'package:xiecheng_demo/widget/local_nav.dart';
import 'package:xiecheng_demo/widget/sales_box.dart';
import 'package:xiecheng_demo/widget/search_bar.dart';
import 'package:xiecheng_demo/widget/sub_nav.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

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
  bool _isLoading = true;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) alpha = 0;
    if (alpha > 1) alpha = 1;
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModule homeModule = await HomeDao.fetch();
      setState(() {
        _bannerList = homeModule.bannerList;
        _localNavList = homeModule.localNavList;
        _subNavList = homeModule.subNavList;
        _gridNav = homeModule.gridNav;
        _salesBoxModel = homeModule.salesBoxModel;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xfff2f2f),
      body: LoadingContainer(
          isLoading: _isLoading,
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: Stack(
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
                      return false;
                    },
                    child: ListView(
                      children: <Widget>[
                        BannerWidget(bannerList: _bannerList),
                        LocalListWidget(localNavList: _localNavList),
                        GridListWidget(gridNav: _gridNav),
                        SubListWidget(subNavList: _subNavList),
                        SalesBoxWidget(salesBoxModel: _salesBoxModel),
                        AuthorSignWidget(),
                      ],
                    ),
                  ),
                ),
                AppBarWidget(appBarAlpha: _appBarAlpha),
              ],
            ),
          )),
    );
  }
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key key,
    @required double appBarAlpha,
  })  : _appBarAlpha = appBarAlpha,
        super(key: key);

  final double _appBarAlpha;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String _currentCity = '天津市';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  (widget._appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: widget._appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: () {
                //jump to search
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              hideLeft: false,
                              hint: SEARCH_BAR_DEFAULT_TEXT,
                            )));
              },
              speakClick: () {
                //jump to speak
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpeakPage()));
              },
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              city: _currentCity,
              leftButtonOnClick: () {
                _jumpToCity(context);
              },
            ),
          ),
        ),
        Container(
          height: widget._appBarAlpha > 0.2 ? 2 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  void _jumpToCity(BuildContext context) async {
    final String result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CityPage()));
    if (result != null) {
      setState(() {
        _currentCity = result;
      });
    }
  }
}

class AuthorSignWidget extends StatelessWidget {
  const AuthorSignWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 7),
      child: Text(
        '本App由吴优完成于2019-08-10',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black38),
      ),
    );
  }
}

class SalesBoxWidget extends StatelessWidget {
  const SalesBoxWidget({
    Key key,
    @required SalesBoxModel salesBoxModel,
  })  : _salesBoxModel = salesBoxModel,
        super(key: key);

  final SalesBoxModel _salesBoxModel;

  @override
  Widget build(BuildContext context) {
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
}

class SubListWidget extends StatelessWidget {
  const SubListWidget({
    Key key,
    @required List<SubNavListItem> subNavList,
  })  : _subNavList = subNavList,
        super(key: key);

  final List<SubNavListItem> _subNavList;

  @override
  Widget build(BuildContext context) {
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
}

class GridListWidget extends StatelessWidget {
  const GridListWidget({
    Key key,
    @required GridNav gridNav,
  })  : _gridNav = gridNav,
        super(key: key);

  final GridNav _gridNav;

  @override
  Widget build(BuildContext context) {
    return GridNavView(
      gridNav: _gridNav,
    );
  }
}

class LocalListWidget extends StatelessWidget {
  const LocalListWidget({
    Key key,
    @required List<LocalNavListItem> localNavList,
  })  : _localNavList = localNavList,
        super(key: key);

  final List<LocalNavListItem> _localNavList;

  @override
  Widget build(BuildContext context) {
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
}

class BannerWidget extends StatelessWidget {
  final List<BannerListModule> _bannerList;

  BannerWidget({
    Key key,
    @required List<BannerListModule> bannerList,
  })  : _bannerList = bannerList,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('banner on create');
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
                      builder: (context) => WebViewWidget(
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
            builder: DotSwiperPaginationBuilder(
              size: 5,
              activeSize: 8,
              color: Colors.white,
              activeColor: Colors.amberAccent,
            )),
      ),
    );
  }
}
