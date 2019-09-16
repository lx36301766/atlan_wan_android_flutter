
import 'package:json_annotation/json_annotation.dart';

part 'user_point_bean.g.dart';

@JsonSerializable()
class UserPointBean {

  int coinCount;
  int rank;
  int userId;
  String username;

  UserPointBean(this.coinCount, this.rank, this.userId, this.username);

  factory UserPointBean.fromJson(Map<String, dynamic> json) => _$UserPointBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointBean instance) => _$UserPointBeanToJson(instance);

}

