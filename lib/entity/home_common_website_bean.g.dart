// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_common_website_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCommonWebsiteBean _$HomeCommonWebsiteBeanFromJson(
    Map<String, dynamic> json) {
  return HomeCommonWebsiteBean(
      json['icon'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['icon'] as String),
      json['id'] as int,
      json['link'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['link'] as String),
      json['name'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['name'] as String),
      json['order'] as int,
      json['visible'] as int);
}

Map<String, dynamic> _$HomeCommonWebsiteBeanToJson(
        HomeCommonWebsiteBean instance) =>
    <String, dynamic>{
      'icon': instance.icon == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.icon),
      'id': instance.id,
      'link': instance.link == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.link),
      'name': instance.name == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.name),
      'order': instance.order,
      'visible': instance.visible
    };
