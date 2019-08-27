import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  List<CityInfo> _cityList = List();
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  //加载城市数据
  void _loadData() async {
    try {
      var value = await rootBundle.loadString('data/cities.json');
      List list = json.decode(value);
      list.forEach((value) {
        _cityList.add(CityInfo(name: value['name']));
      });
      _handleList(_cityList);
      setState(() {
        _cityList = _cityList;
      });
    } catch (e) {
      print(e);
    }
  }

  //排序
  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  //tag更改
  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('选择城市'),
//        leading: GestureDetector(
//          onTap: () {
//            Navigator.pop(context);
//          },
//          child: Icon(Icons.arrow_back),
//        ),
//      ),
      body: Column(
        children: <Widget>[
          _appBar(context),
          ListTile(
              title: Text("定位城市"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.place,
                    size: 20.0,
                  ),
                  Text(" 天津市"),
                ],
              )),
          Divider(
            height: .0,
          ),
          Expanded(
              flex: 1,
              child: AzListView(
                data: _cityList,
                itemBuilder: (context, model) => _buildListItem(model),
                suspensionWidget: _buildSusWidget(_suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: _onSusTagChanged,
                header: AzListViewHeader(
                    tag: "★",
                    height: 120,
                    builder: (context) {
                      return _buildHeader();
                    }),
                indexHintBuilder: (context, hint) {
                  return Container(
                    alignment: Alignment.center,
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.black54, shape: BoxShape.circle),
                    child: Text(hint,
                        style: TextStyle(color: Colors.white, fontSize: 30.0)),
                  );
                },
              )),
        ],
      ),
    );
  }

  //自定义头部
  Widget _buildHeader() {
    List<CityInfo> hotCityList = List();
    hotCityList.addAll([
      CityInfo(name: "北京市"),
      CityInfo(name: "上海市"),
      CityInfo(name: "广州市"),
      CityInfo(name: "深圳市"),
      CityInfo(name: "杭州市"),
      CityInfo(name: "成都市"),
      CityInfo(name: "天津市"),
      CityInfo(name: "合肥市"),
    ]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.0,
        children: hotCityList.map((e) {
          return OutlineButton(
            borderSide: BorderSide(color: Colors.grey[300], width: .5),
            child: Text(e.name),
            onPressed: () {
              print("OnItemClick: $e");
              Navigator.pop(context, e.name);
            },
          );
        }).toList(),
      ),
    );
  }

  //自定义tag
  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  //自定义item
  Widget _buildListItem(CityInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              print("OnItemClick: $model");
              Navigator.pop(context, model.name);
            },
          ),
        )
      ],
    );
  }

  Widget _appBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            width: double.infinity,
            height: 56,
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 26,
                    )),
              ),
              title: Text(
                '选择城市',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
          ),
          Container(
            height: 0.5,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 0.6)]),
          )
        ],
      ),
    );
  }
}

class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
