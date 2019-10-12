// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_hot_key_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHotKeyBean _$HomeHotKeyBeanFromJson(Map<String, dynamic> json) {
  return HomeHotKeyBean(
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

Map<String, dynamic> _$HomeHotKeyBeanToJson(HomeHotKeyBean instance) =>
    <String, dynamic>{
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
