
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ApiUrl.dart';


class HttpCall<T> {

  static Future fetchGet(String url) async {
    final response = await http.get(url);
    return json.decode(response.body);
  }

}
