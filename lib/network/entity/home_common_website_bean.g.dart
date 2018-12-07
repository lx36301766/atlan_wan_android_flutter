// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_common_website_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCommonWebsiteBean _$HomeCommonWebsiteBeanFromJson(
    Map<String, dynamic> json) {
  return HomeCommonWebsiteBean(
      json['icon'] as String,
      json['id'] as int,
      json['link'] as String,
      json['name'] as String,
      json['order'] as int,
      json['visible'] as int);
}

Map<String, dynamic> _$HomeCommonWebsiteBeanToJson(
        HomeCommonWebsiteBean instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible
    };
