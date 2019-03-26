
import 'package:json_annotation/json_annotation.dart';

part 'home_common_website_bean.g.dart';

@JsonSerializable()
class HomeCommonWebsiteBean {

  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  HomeCommonWebsiteBean(this.icon, this.id, this.link, this.name, this.order, this.visible);

  factory HomeCommonWebsiteBean.fromJson(Map<String, dynamic> json) => _$HomeCommonWebsiteBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCommonWebsiteBeanToJson(this);

  @override
  String toString() {
    return 'HomeCommonWebsiteBean{icon: $icon, id: $id, link: $link, name: $name, order: $order, visible: $visible}';
  }

}
