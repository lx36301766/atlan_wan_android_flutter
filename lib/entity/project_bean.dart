
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';

class ProjectBean extends KnowledgeSystemBean {

  ProjectBean(List<ProjectBean> children, int courseId, int id, String name, int order, int parentChapterId,
      bool userControlSetTop, int visible) : super(
      children,
      courseId,
      id,
      name,
      order,
      parentChapterId,
      userControlSetTop,
      visible);

  factory ProjectBean.fromJson(Map<String, dynamic> json) => _$ProjectBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectBeanToJson(this);

}

ProjectBean _$ProjectBeanFromJson(Map<String, dynamic> json) {
  return ProjectBean(
      (json['children'] as List)
          ?.map((e) => e == null
          ? null
          : ProjectBean.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$ProjectBeanToJson(
    ProjectBean instance) =>
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
