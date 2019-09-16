
import 'package:json_annotation/json_annotation.dart';
import 'user_point_bean.dart';

part 'user_point_leaderboard_bean.g.dart';

@JsonSerializable()
class UserPointLeaderboardBean {

  int curPage;
  List<UserPointBean> datas;
  int offset;
  bool over;
  int size;
  int total;

  UserPointLeaderboardBean(this.curPage, this.datas, this.offset, this.over, this.size, this.total);

  factory UserPointLeaderboardBean.fromJson(Map<String, dynamic> json) => _$UserPointLeaderboardBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointLeaderboardBean instance) => _$UserPointLeaderboardBeanToJson(instance);

}