
import 'dart:async';

import 'package:atlan_wan_android_flutter/entity/get_collect_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_common_website_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_hot_key_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:atlan_wan_android_flutter/entity/navigation_bean.dart';
import 'package:atlan_wan_android_flutter/entity/share_articles_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_earn_points_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_rank_list_bean.dart';

import 'api_network.dart';
import 'api_url.dart';

import 'package:sprintf/sprintf.dart';

class Api {

  static ApiNetwork api = ApiNetwork();
  
  // 首页接口
  static Future<HomeListBean> getHomeList(int page) async =>
      HomeListBean.fromJson(await api.fetchGet(apiHomeList + page.toString()));

  static Future<List<HomeBannerBean>> getHomeBanner() async {
    List data = await api.fetchGet(apiHomeBanner);
    return List.generate(data.length, (int index) => HomeBannerBean.fromJson(data[index]));
  }

  static Future<List<HomeCommonWebsiteBean>> getHomeCommonWebsite() async {
    List data = await api.fetchGet(apiCommonWebsite);
    return List.generate(data.length, (int index) => HomeCommonWebsiteBean.fromJson(data[index]));
  }

  static Future<List<HomeHotKeyBean>> getSearchHotKey() async {
    List data = await api.fetchGet(apiSearchHotKey);
    return List.generate(data.length, (int index) => HomeHotKeyBean.fromJson(data[index]));
  }

  static Future<List<HomeListDataBean>> getArticleTop() async {
    List data = await api.fetchGet(apiArticleTop);
    return List.generate(data.length, (int index) => HomeListDataBean.fromJson(data[index]));
  }


  // 体系接口
  static Future<List<KnowledgeSystemBean>> getKnowledgeSystem() async {
    List data = await api.fetchGet(apiKnowledgeSystem);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getKnowledgeSystemChildren(int page, int id) async {
    var data = await api.fetchGet(apiKnowledgeSystemChildren + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  static Future<HomeListBean> getAuthorArticleList(String author, int page) async {
    var data = await api.fetchGet(apiGetArticleByAuthor + page.toString(), {"author": "$author"});
    return HomeListBean.fromJson(data);
  }

  // 导航接口
  static Future<List<NavigationBean>> getNavigation() async {
    List data = await api.fetchGet(apiNavigation);
    return List.generate(data.length, (int index) => NavigationBean.fromJson(data[index]));
  }

  // 项目接口
  static Future<List<KnowledgeSystemBean>> getProject() async {
    List data = await api.fetchGet(apiProject);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getProjectList(int page, int id) async {
    var data = await api.fetchGet(apiProjectList + page.toString(), {"cid": "$id"});
    return HomeListBean.fromJson(data);
  }

  // 公共号接口
  static Future<List<KnowledgeSystemBean>> getWeChatAuthorList() async {
    List data = await api.fetchGet(apiWXList);
    return List.generate(data.length, (int index) => KnowledgeSystemBean.fromJson(data[index]));
  }

  static Future<HomeListBean> getWeChatArticleList(int page, int id, [String searchKey]) async {
    String urlPathSuffix = apiWXListItem + id.toString() + "/" + page.toString();
    var data = await api.fetchGet(urlPathSuffix, searchKey == null ? null : {"k": "$searchKey"});
    return HomeListBean.fromJson(data);
  }

  // 登录/注册接口
  static Future<LoginRegisterBean> login(String userName, String password) async {
    var data = await api.fetchPost(apiLogin, {"username": userName, "password": password});
    return LoginRegisterBean.fromJson(data);
  }

  static Future<LoginRegisterBean> register(String userName, String password, String repassword) async {
    var data = await api.fetchPost(apiRegister, {"username": userName, "password": password, "repassword": repassword});
    return LoginRegisterBean.fromJson(data);
  }

  static Future<void> logout() => api.fetchGet(apiLogout);


  // 收藏文章相关接口
  static Future<GetCollectListBean> getCollectList(int page) async {
    var data = await api.fetchGet(apiGetCollect + page.toString());
    return GetCollectListBean.fromJson(data);
  }

  static Future<void> addCollectInside(int id) async {
    await api.fetchPost(apiAddCollectInside + id.toString() + '/json');
    return null;
  }

  static Future<GetCollectListBean> addCollectOutside(String title, String author, String link) async {
    var data = await api.fetchPost(apiAddCollectOutside, {"title": title, "author": author, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<void> deleteCollect(int originId) async {
    await api.fetchPost(apiDeleteCollect + originId.toString() + '/json');
    return null;
  }

  static Future<void> deleteCollect2(int originId) async {
    await api.fetchPost(apiDeleteCollect2 + originId.toString() + '/json');
    return null;
  }

  // 收藏网站相关接口
  static Future<GetCollectListBean> getCollectWebsite() async {
    var data = await api.fetchPost(apiGetCollectWebsite);
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> addCollectWebsite(String name, String link) async {
    var data = await api.fetchPost(apiAddCollectWebsite, {"name": name, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> updateCollectWebsite(int id, String name, String link) async {
    var data = await api.fetchPost(apiUpdateCollectWebsite, {"id:": "$id", "name": name, "link": link});
    return GetCollectListBean.fromJson(data);
  }

  static Future<GetCollectListBean> deleteCollectWebsite(int id) async {
    var data = await api.fetchPost(apiDeleteCollectWebsite, {"id:": "$id"});
    return GetCollectListBean.fromJson(data);
  }


  // 搜索相关接口
  static Future<HomeListBean> getSearchResult(int page, String key) async {
    var data = await api.fetchPost("$apiGetSearchResult$page/json", {"k": "$key"});
    return HomeListBean.fromJson(data);
  }

  // TODO相关接口


  // 积分相关接口
  static Future<UserPointRankListBean> getUserPointRankList(int page) async {
    var data = await api.fetchGet(apiGetPointRankList + page.toString());
    return UserPointRankListBean.fromJson(data);
  }

  static Future<UserPointBean> getUserPoint() async =>
      UserPointBean.fromJson(await api.fetchGet(apiGetUserPoint));

  static Future<UserEarnPointsListBean> getUserEarnPointsList(int page) async {
    var data = await api.fetchGet("$apiUserEarnPointList$page");
    return UserEarnPointsListBean.fromJson(data);
  }


  //广场接口
  static Future<HomeListBean> getUserArticleList(int page) async =>
      HomeListBean.fromJson(await api.fetchGet("$apiUserArticleList$page"));

  static Future<ShareArticlesListBean> getShareUserArticleList(int userId, int page) async =>
      ShareArticlesListBean.fromJson(await api.fetchGet(sprintf(apiShareUserArticleList, [userId, page])));

}
