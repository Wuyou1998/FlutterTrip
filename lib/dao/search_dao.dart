import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xiecheng_demo/modle/search_modle.dart';

const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchDao {
  static Future<SearchModel> fetch() async {
    final response = await http.get(SEARCH_URL);
    if (response.statusCode == 200) {
      //请求成功
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
