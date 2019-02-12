
import 'package:atlan_wan_android_flutter/network/api_resp.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_common_website_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_hot_key_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_url.dart';


class ApiRequester {

  static Future<HomeListBean> getHomeList(int page) async {
    var data = await fetchGet(BASE_URL + API_HOME_LIST + page.toString());
    return HomeListBean.fromJson(data);
  }

  static Future<List<HomeBannerBean>> getHomeBanner() async {
    var data = await fetchGet(BASE_URL + API_HOME_BANNER);
    List<HomeBannerBean> ret = List();
    data.forEach((item) => ret.add(HomeBannerBean.fromJson(item)));
    return ret;
  }

  static Future<List<HomeCommonWebsiteBean>> getHomeCommonWebsite() async {
    var data = await fetchGet(BASE_URL + API_COMMON_WEBSITE);
    List<HomeCommonWebsiteBean> ret = List();
    data.forEach((item) => ret.add(HomeCommonWebsiteBean.fromJson(item)));
    return ret;
  }

  static Future<List<HomeHotKeyBean>> getHomeHotKey() async {
    var data = await fetchGet(BASE_URL + API_SEARCH_HOTKEY);
    List<HomeHotKeyBean> ret = List();
    data.forEach((item) => ret.add(HomeHotKeyBean.fromJson(item)));
    return ret;
  }





  static Future fetchGet(String url) async {
    final response = await http.get(url + "/json");
    var map = json.decode(response.body);
    return ApiResp.fromJson(map).data;
  }

}
