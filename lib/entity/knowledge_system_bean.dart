
import 'package:json_annotation/json_annotation.dart';

part 'knowledge_system_bean.g.dart';

@JsonSerializable()
class KnowledgeSystemBean {

  List<KnowledgeSystemBean> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  KnowledgeSystemBean(this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId,
      this.userControlSetTop, this.visible);

  factory KnowledgeSystemBean.fromJson(Map<String, dynamic> json) => _$KnowledgeSystemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeSystemBeanToJson(this);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is KnowledgeSystemBean &&
              runtimeType == other.runtimeType &&
              courseId == other.courseId &&
              id == other.id &&
              name == other.name &&
              parentChapterId == other.parentChapterId;

  @override
  int get hashCode =>
      courseId.hashCode ^
      id.hashCode ^
      name.hashCode ^
      parentChapterId.hashCode;

  @override
  String toString() {
    return 'KnowledgeSystemBean{children: $children, courseId: $courseId, id: $id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible}';
  }

}
