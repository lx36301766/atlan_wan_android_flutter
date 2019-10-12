// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_system_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeSystemBean _$KnowledgeSystemBeanFromJson(Map<String, dynamic> json) {
  return KnowledgeSystemBean(
      (json['children'] as List)
          ?.map((e) => e == null
              ? null
              : KnowledgeSystemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['courseId'] as int,
      json['id'] as int,
      json['name'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['name'] as String),
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int);
}

Map<String, dynamic> _$KnowledgeSystemBeanToJson(
        KnowledgeSystemBean instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.name),
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible
    };
