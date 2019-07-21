
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api_resp.dart';
import 'package:atlan_wan_android_flutter/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_common_website_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_hot_key_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/entity/navigation_bean.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_url.dart';


class ApiRequester {

  // 首页接口
  static Future<HomeListBean> getHomeList(int page) async => HomeListBean.fromJson(await fetchGet(apiHomeList + page.toString()));

  static Future<List<HomeBannerBean>> getHomeBanner() async {
    List data = await fetchGet(apiHomeBanner);
    return List.generate(data.length, (int index) => HomeBannerBean.fromJson(data[index]));
  }

  static Future<List<HomeCommonWebsiteBean>> getHomeCommonWebsite() async {
    List data = await fetchGet(apiCommonWebsite);
    return List.generate(data.length, (int index) => HomeCommonWebsiteBean.fromJson(data[index]));
  }

  static Future<List<HomeHotKeyBean>> getHomeHotKey() async {
    List data = await fetchGet(apiSearchHotKey);
    return List.generate(data.length, (int index) => HomeHotKeyBean.fromJson(data[index]));
  }

  // 体系接口
  static Future<List<KnowledgeSystemBean>> getKnowledgeSystem() async {
    List data = await fetchGet(apiKnowledgeSystem);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getKnowledgeSystemChildren(int page, int id) async {
    var data = await fetchGet(apiHomeList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  // 导航接口
  static Future<List<NavigationBean>> getNavigation() async {
    List data = await fetchGet(apiNavigation);
    return List.generate(data.length, (int index) => NavigationBean.fromJson(data[index]));
  }

  // 项目接口
  static Future<List<KnowledgeSystemBean>> getProject() async {
    List data = await fetchGet(apiProject);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getProjectList(int page, int id) async {
    var data = await fetchGet(apiProjectList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  // 公共号接口
  static Future<List<KnowledgeSystemBean>> getWeChatAuthorList() async {
    List data = await fetchGet(apiWXList);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getWeChatArticleList(int page, int id, [String searchKey]) async {
    String urlPathSuffix = apiWXListItem + id.toString() + "/" + page.toString();
    var data = await fetchGet(urlPathSuffix, searchKey == null ? null : {"k": "$searchKey"});
    return HomeListBean.fromJson(data);
  }

  // 登录接口
  static Future/**TODO**/ postLogin(String userName, String password) async {
    var data = await fetchPost(apiLogin, {"userName": userName, "password": password});
    // FIXME
    return HomeListBean.fromJson(data);
  }

  // 注册接口
  static Future/**TODO**/ postRegister(String userName, String password, String repassword) async {
    var data = await fetchPost(apiRegister, {"userName": userName, "password": password, "repassword": repassword});
    // FIXME
    return HomeListBean.fromJson(data);
  }

  // 退出
  static Future/**TODO**/ getLogout() async {
    var data = await fetchGet(apiLogout);
    // FIXME
    return HomeListBean.fromJson(data);
  }


  static Future fetchGet(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path + "/json";
    if (arguments != null) {
      url += "?";
      arguments.forEach((key, value) => url += "$key=$value&");
      url = url.substring(0, url.length - 1);
    }
    print("fetchGet url = $url");
    final response = await http.get(url);
    var map = json.decode(response.body);
    return ApiResp.fromJson(map).data;
  }

  static Future fetchPost(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path;
    print("fetchPost url = $url, body=$arguments");
    final response = await http.post(url, body: arguments);
    var map = json.decode(response.body);
    return ApiResp.fromJson(map).data;
  }

}
