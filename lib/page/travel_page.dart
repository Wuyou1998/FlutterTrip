import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:xiecheng_demo/dao/travel_tab_dao.dart';
import 'package:xiecheng_demo/model/travel_tab_model.dart';
import 'package:xiecheng_demo/page/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _tabController;
  List<TravelTab> _tabs = [];
  TravelTabModel _tabModel;

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _tabController = TabController(
          length: model.tabs.length, vsync: this); //fix tab label 空白问题
      setState(() {
        _tabs = model.tabs;
        _tabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                indicator: UnderlineIndicator(
                    strokeCap: StrokeCap.round,
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Color(0xff2fcfbb),
                        width: 2),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: _tabs.map<Tab>((TravelTab tab) {
                  return Tab(
                    child: Text(tab.labelName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,),),
                  );
                }).toList()),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
          ),
          Flexible(
            child: TabBarView(controller: _tabController, children: _tabs.map((TravelTab tab){
              return TravelTabPage(travelUrl: _tabModel.url,groupChannelCode: tab.groupChannelCode,params: _tabModel.params,);
            }).toList()),
          )
        ],
      ),
    );
  }
}
