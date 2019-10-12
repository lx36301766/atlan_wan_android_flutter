
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navigation_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class NavigationBean {

  List<HomeListDataBean> articles;
  int cid;
  String name;

  NavigationBean(this.articles, this.cid, this.name);

  factory NavigationBean.fromJson(Map<String, dynamic> json) => _$NavigationBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationBeanToJson(this);

  @override
  String toString() {
    return 'NavigationBean{articles: $articles, cid: $cid, name: $name}';
  }

}
