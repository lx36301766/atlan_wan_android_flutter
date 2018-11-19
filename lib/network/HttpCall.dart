
import 'dart:convert';
import 'package:http/http.dart' as http;


class HttpCall<T> {

  static Future fetchGet(String url) async {
    final response = await http.get(url);
    final jsonStr = json.decode(response.body);
  }

}