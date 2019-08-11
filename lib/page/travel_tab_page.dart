import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xiecheng_demo/dao/travel_dao.dart';
import 'package:xiecheng_demo/modle/travel_model.dart';
import 'package:xiecheng_demo/widget/loading_container.dart';
import 'package:xiecheng_demo/widget/web_view_widget.dart';

const PAGE_SIZE = 10;
const PAGE_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;

  const TravelTabPage(
      {Key key, this.travelUrl, this.groupChannelCode, this.params})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> _travelItems;
  int _pageIndex = 1;
  bool _isLoading = true;
  ScrollController _scrollController=ScrollController();
  @override
  void initState() {
    _loadData();
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        _loadData(loadMore: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
          isLoading: _isLoading,
          child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: MediaQuery.removeViewPadding(
                context: context,
                removeTop: true,
                child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 4,
                  itemCount: _travelItems?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) => TravelItemView(
                    item: _travelItems[index],
                    index: index,
                  ),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                ),
              ))),
    );
  }

  void _loadData({loadMore=false}) {
    if(loadMore){
      _pageIndex++;
    }else{
      _pageIndex=1;
    }
    TravelDao.fetch(widget.travelUrl ?? PAGE_URL, widget.params,
            widget.groupChannelCode, _pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (_travelItems != null) {
          _travelItems.addAll(items);
        } else {
          _travelItems = items;
        }
        _isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        //移除article为空的模型
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  @override
  //当前页面是保活的
  bool get wantKeepAlive => true;

  Future<void> _handleRefresh() async{
    _loadData();
  }
}



class TravelItemView extends StatelessWidget {
  final TravelItem item;
  final int index;

  const TravelItemView({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article.urls != null && item.article.urls.length > 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewWidget(
                        url: item.article.urls[0].h5Url,
                        title: '旅拍详情',
                      )));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
            left: 5,
            bottom: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _positionName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _positionName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知位置'
        : item.article.pois[0]?.poiName ?? '未知位置';
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PhysicalModel(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.article?.author?.coverImage?.dynamicUrl,
              width: 24,
              height: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: 90,
            child: Text(
              item.article.author?.nickName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  item.article?.likeCount.toString() ?? '0',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
