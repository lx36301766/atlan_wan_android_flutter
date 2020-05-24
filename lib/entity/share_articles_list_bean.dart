import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home_list_bean.dart';

part 'share_articles_list_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class ShareArticlesListBean {

  CoinInfoBean coinInfo;
  HomeListBean shareArticles;

  ShareArticlesListBean(this.coinInfo, this.shareArticles);

  factory ShareArticlesListBean.fromJson(Map<String, dynamic> json) => _$ShareArticlesListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ShareArticlesListBeanToJson(this);

}

@JsonSerializable()
@UnescapeJsonConvert()
class CoinInfoBean {

  int coinCount;
  int level;
  String rank;
  int userId;
  String username;

  CoinInfoBean(this.coinCount, this.level, this.rank, this.userId, this.username);

  factory CoinInfoBean.fromJson(Map<String, dynamic> json) => _$CoinInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CoinInfoBeanToJson(this);

}
