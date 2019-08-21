
import 'dart:async';

import 'package:atlan_wan_android_flutter/entity/get_collect_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_common_website_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_hot_key_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:atlan_wan_android_flutter/entity/navigation_bean.dart';

import 'api_url.dart';
import 'dio_manager.dart';


class Api {

  // 首页接口
  static Future<HomeListBean> getHomeList(int page) async => HomeListBean
      .fromJson(await DioManager().fetchGet(apiHomeList + page.toString()));

  static Future<List<HomeBannerBean>> getHomeBanner() async {
    List data = await DioManager().fetchGet(apiHomeBanner);
    return List.generate(data.length, (int index) => HomeBannerBean.fromJson(data[index]));
  }

  static Future<List<HomeCommonWebsiteBean>> getHomeCommonWebsite() async {
    List data = await DioManager().fetchGet(apiCommonWebsite);
    return List.generate(data.length, (int index) => HomeCommonWebsiteBean.fromJson(data[index]));
  }

  static Future<List<HomeHotKeyBean>> getHomeHotKey() async {
    List data = await DioManager().fetchGet(apiSearchHotKey);
    return List.generate(data.length, (int index) => HomeHotKeyBean.fromJson(data[index]));
  }

  static Future<List<HomeListDataBean>> getArticleTop() async {
    List data = await DioManager().fetchGet(apiArticleTop);
    return List.generate(data.length, (int index) => HomeListDataBean.fromJson(data[index]));
  }


  // 体系接口
  static Future<List<KnowledgeSystemBean>> getKnowledgeSystem() async {
    List data = await DioManager().fetchGet(apiKnowledgeSystem);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getKnowledgeSystemChildren(int page, int id) async {
    var data = await DioManager().fetchGet(apiHomeList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  // 导航接口
  static Future<List<NavigationBean>> getNavigation() async {
    List data = await DioManager().fetchGet(apiNavigation);
    return List.generate(data.length, (int index) => NavigationBean.fromJson(data[index]));
  }

  // 项目接口
  static Future<List<KnowledgeSystemBean>> getProject() async {
    List data = await DioManager().fetchGet(apiProject);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getProjectList(int page, int id) async {
    var data = await DioManager().fetchGet(apiProjectList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  // 公共号接口
  static Future<List<KnowledgeSystemBean>> getWeChatAuthorList() async {
    List data = await DioManager().fetchGet(apiWXList);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getWeChatArticleList(int page, int id, [String searchKey]) async {
    String urlPathSuffix = apiWXListItem + id.toString() + "/" + page.toString();
    var data = await DioManager().fetchGet(urlPathSuffix, searchKey == null ? null : {"k": "$searchKey"});
    return HomeListBean.fromJson(data);
  }

  // 登录/注册接口
  static Future<LoginRegisterBean> login(String userName, String password) async {
    var data = await DioManager().fetchPost(apiLogin, {"username": userName, "password": password});
    return LoginRegisterBean.fromJson(data);
  }

  static Future<LoginRegisterBean> register(String userName, String password, String repassword) async {
    var data = await DioManager().fetchPost(apiRegister, {"userName": userName, "password": password, "repassword": repassword});
    return LoginRegisterBean.fromJson(data);
  }

  static Future<void> logout() => DioManager().fetchGet(apiLogout);


  // 收藏文章相关接口
  static Future<GetCollectListBean> getCollectList(int page) async {
    var data = await DioManager().fetchGet(apiGetCollect + page.toString());
    return GetCollectListBean.fromJson(data);
  }

  static Future<void> addCollectInside(int id) async {
    await DioManager().fetchPost(apiAddCollectInside + id.toString() + '/json');
    return null;
  }

  static Future<GetCollectListBean> addCollectOutside(String title, String author, String link) async {
    var data = await DioManager().fetchPost(apiAddCollectOutside, {"title": title, "author": author, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> deleteCollect(int originId) async {
    var data = await DioManager().fetchPost(apiDeleteCollect + originId.toString());
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> deleteCollect2(int originId) async {
    var data = await DioManager().fetchPost(apiDeleteCollect2 + originId.toString());
    return GetCollectListBean.fromJson(data);
  }

  // 收藏网站相关接口
  static Future<GetCollectListBean> getCollectWebsite() async {
    var data = await DioManager().fetchPost(apiGetCollectWebsite);
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> addCollectWebsite(String name, String link) async {
    var data = await DioManager().fetchPost(apiAddCollectWebsite, {"name": name, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> updateCollectWebsite(int id, String name, String link) async {
    var data = await DioManager().fetchPost(apiUpdateCollectWebsite, {"id:": "$id", "name": name, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> deleteCollectWebsite(int id) async {
    var data = await DioManager().fetchPost(apiDeleteCollectWebsite, {"id:": "$id"});
    return GetCollectListBean.fromJson(data);
  }



}
