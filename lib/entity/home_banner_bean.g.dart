// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerBean _$HomeBannerBeanFromJson(Map<String, dynamic> json) {
  return HomeBannerBean(
      json['desc'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['desc'] as String),
      json['id'] as int,
      json['imagePath'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['imagePath'] as String),
      json['isVisible'] as int,
      json['order'] as int,
      json['title'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['title'] as String),
      json['type'] as int,
      json['url'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['url'] as String));
}

Map<String, dynamic> _$HomeBannerBeanToJson(HomeBannerBean instance) =>
    <String, dynamic>{
      'desc': instance.desc == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.desc),
      'id': instance.id,
      'imagePath': instance.imagePath == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.imagePath),
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.title),
      'type': instance.type,
      'url': instance.url == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.url)
    };
