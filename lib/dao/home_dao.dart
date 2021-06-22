import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xiecheng_demo/model/home_module.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModule> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      //请求成功
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModule.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}
