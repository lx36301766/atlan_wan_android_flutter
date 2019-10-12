
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_point_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class UserPointBean {

  int coinCount;
  int rank;
  int userId;
  String username;

  UserPointBean(this.coinCount, this.rank, this.userId, this.username);

  factory UserPointBean.fromJson(Map<String, dynamic> json) => _$UserPointBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointBean instance) => _$UserPointBeanToJson(instance);

  @override
  String toString() {
    return 'UserPointBean{coinCount: $coinCount, rank: $rank, userId: $userId, username: $username}';
  }

}

