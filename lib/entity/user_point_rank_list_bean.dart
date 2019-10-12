
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user_point_bean.dart';

part 'user_point_rank_list_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class UserPointRankListBean {

  int curPage;
  List<UserPointBean> datas;
  int offset;
  bool over;
  int size;
  int total;

  UserPointRankListBean(this.curPage, this.datas, this.offset, this.over, this.size, this.total);

  factory UserPointRankListBean.fromJson(Map<String, dynamic> json) => _$UserPointRankListBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointRankListBean instance) => _$UserPointRankListBeanToJson(instance);

}