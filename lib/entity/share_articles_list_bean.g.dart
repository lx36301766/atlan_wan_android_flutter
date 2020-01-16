// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_articles_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareArticlesListBean _$ShareArticlesListBeanFromJson(
    Map<String, dynamic> json) {
  return ShareArticlesListBean(
      json['coinInfo'] == null
          ? null
          : CoinInfoBean.fromJson(json['coinInfo'] as Map<String, dynamic>),
      json['shareArticles'] == null
          ? null
          : HomeListBean.fromJson(
              json['shareArticles'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ShareArticlesListBeanToJson(
        ShareArticlesListBean instance) =>
    <String, dynamic>{
      'coinInfo': instance.coinInfo,
      'shareArticles': instance.shareArticles
    };

CoinInfoBean _$CoinInfoBeanFromJson(Map<String, dynamic> json) {
  return CoinInfoBean(
      json['coinCount'] as int,
      json['level'] as int,
      json['rank'] as int,
      json['userId'] as int,
      json['username'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['username'] as String));
}

Map<String, dynamic> _$CoinInfoBeanToJson(CoinInfoBean instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.username)
    };
