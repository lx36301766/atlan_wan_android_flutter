
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api_resp.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_common_website_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_hot_key_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/knowledge_system_bean.dart';
import 'package:html_unescape/html_unescape.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_url.dart';


class ApiRequester {

  static HtmlUnescape _htmlUnescape = HtmlUnescape();

  static Future<HomeListBean> getHomeList(int page) async {
    var data = await fetchGet(apiHomeList + page.toString());
    return HomeListBean.fromJson(data);
  }

  static Future<List<HomeBannerBean>> getHomeBanner() async {
    var data = await fetchGet(apiHomeBanner);
    List<HomeBannerBean> ret = [];
    data.forEach((item) => ret.add(HomeBannerBean.fromJson(item)));
    return ret;
  }

  static Future<List<HomeCommonWebsiteBean>> getHomeCommonWebsite() async {
    var data = await fetchGet(apiCommonWebsite);
    List<HomeCommonWebsiteBean> ret = [];
    data.forEach((item) => ret.add(HomeCommonWebsiteBean.fromJson(item)));
    return ret;
  }

  static Future<List<HomeHotKeyBean>> getHomeHotKey() async {
    var data = await fetchGet(apiSearchHotKey);
    List<HomeHotKeyBean> ret = [];
    data.forEach((item) => ret.add(HomeHotKeyBean.fromJson(item)));
    return ret;
  }


  static Future<List<KnowledgeSystemBean>> getKnowledgeSystem() async {
    var data = await fetchGet(apiKnowledgeSystem);
    List<KnowledgeSystemBean> ret = [];
    data.forEach((item) => ret.add(KnowledgeSystemBean.fromJson(item)));
    return ret;
  }

  static Future<HomeListBean> getKnowledgeSystemChildren(int page, int id) async {
    var data = await fetchGet(apiHomeList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }



  static Future fetchGet(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path + "/json";
    if (arguments != null) {
      url += "?";
      arguments.forEach((key, value) => url += "$key=$value&");
      url = url.substring(0, url.length - 1);
    }
    final response = await http.get(url);
    var map = json.decode(_htmlUnescape.convert(response.body));
    return ApiResp.fromJson(map).data;
  }

}
