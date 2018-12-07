// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_hot_key_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHotKeyBean _$HomeHotKeyBeanFromJson(Map<String, dynamic> json) {
  return HomeHotKeyBean(json['id'] as int, json['link'] as String,
      json['name'] as String, json['order'] as int, json['visible'] as int);
}

Map<String, dynamic> _$HomeHotKeyBeanToJson(HomeHotKeyBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible
    };
