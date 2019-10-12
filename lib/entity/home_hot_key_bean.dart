
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_hot_key_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class HomeHotKeyBean {

  int id;
  String link;
  String name;
  int order;
  int visible;

  HomeHotKeyBean(this.id, this.link, this.name, this.order, this.visible);

  factory HomeHotKeyBean.fromJson(Map<String, dynamic> json) => _$HomeHotKeyBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeHotKeyBeanToJson(this);

  @override
  String toString() {
    return 'HomeHotKeyBean{id: $id, link: $link, name: $name, order: $order, visible: $visible}';
  }


}
