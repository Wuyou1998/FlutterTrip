import 'package:flutter/material.dart';
import 'package:xiecheng_demo/dao/search_dao.dart';
import 'package:xiecheng_demo/modle/search_modle.dart';
import 'package:xiecheng_demo/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _showResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: false,
            defaultText: '12345679',
            hint: '987654321',
            leftButtonOnClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          ),
          InkWell(
            onTap: () {
              SearchDao.fetch().then((SearchModel value) {
                setState(() {
                  _showResult = value.data[0].url;
                });
              });
            },
            child: Text('Get'),
          ),
          Text(_showResult)
        ],
      ),
    );
  }

  _onTextChanged(text) {}
}
