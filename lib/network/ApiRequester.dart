
import 'package:atlan_wan_android_flutter/network/ApiResp.dart';
import 'package:atlan_wan_android_flutter/network/entity/HomeListResp.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ApiUrl.dart';


class ApiRequester {

  static Future<HomeListResp> getHomeList(int page) async {
    var jsonMap = await fetchGet(BASE_URL + API_HOME_LIST + page.toString());
    var data = ApiResp.fromJson(jsonMap).data;
    return HomeListResp.fromJson(data);
  }

  static Future<HomeListResp> getHomeList2(int page) async {
    var jsonMap = await fetchGet(BASE_URL + API_HOME_LIST + page.toString());
    return HomeListResp.fromJson(ApiResp.fromJson(jsonMap).data);
  }




  static Future fetchGet(String url) async {
    final response = await http.get(url + "/json");
    return json.decode(response.body);
  }

}
