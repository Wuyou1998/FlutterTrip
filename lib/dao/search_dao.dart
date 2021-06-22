import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xiecheng_demo/model/search_modle.dart';

class SearchDao {
  static Future<SearchModel> fetch(String url, text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //请求成功
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel searchModel = SearchModel.fromJson(result);
      //只有当前输入内容与服务端返回内容一致才会渲染
      searchModel.keyword = text;
      return searchModel;
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
