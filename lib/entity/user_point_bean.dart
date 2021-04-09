
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_point_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class UserPointBean {

  int coinCount;
  int level;
  String nickname;
  String rank;
  int userId;
  String username;

  UserPointBean(this.coinCount, this.level, this.nickname, this.rank, this.userId, this.username);

  factory UserPointBean.fromJson(Map<String, dynamic> json) => _$UserPointBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointBean instance) => _$UserPointBeanToJson(instance);

  @override
  String toString() {
    return 'UserPointBean{coinCount: $coinCount, level: $level, nickname: $nickname, rank: $rank, userId: $userId, username: $username}';
  }

}

