
import 'package:json_annotation/json_annotation.dart';

part 'login_register_bean.g.dart';

@JsonSerializable()
class LoginRegisterBean {

  int id;
  bool admin;
  List<int> collectIds;
  String email;
  String icon;
  String username;
  String nickname;
  String password;
  String token;
  int type;

  LoginRegisterBean.abc();

  LoginRegisterBean(this.id, this.admin, this.collectIds, this.email, this.icon,
      this.username, this.nickname, this.password, this.token, this.type);

  factory LoginRegisterBean.fromJson(Map<String, dynamic> json) => _$LoginRegisterBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRegisterBeanToJson(this);

  @override
  String toString() {
    return 'LoginBean{admin: $admin, collectIds: $collectIds, email: $email, icon: $icon, id: $id, username: $username, nickname: $nickname, password: $password, token: $token, type: $type}';
  }

}
