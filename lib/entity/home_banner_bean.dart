
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_banner_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class HomeBannerBean {

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  HomeBannerBean(this.desc, this.id, this.imagePath, this.isVisible, this.order, this.title, this.type, this.url);

  factory HomeBannerBean.fromJson(Map<String, dynamic> json) => _$HomeBannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerBeanToJson(this);

  @override
  String toString() {
    return 'HomeBannerBean{desc: $desc, id: $id, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url}';
  }

}
