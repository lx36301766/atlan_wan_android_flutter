// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationBean _$NavigationBeanFromJson(Map<String, dynamic> json) {
  return NavigationBean(
      (json['articles'] as List)
          ?.map((e) => e == null
              ? null
              : HomeListDataBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['cid'] as int,
      json['name'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['name'] as String));
}

Map<String, dynamic> _$NavigationBeanToJson(NavigationBean instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.name)
    };
