// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_register_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterBean _$LoginRegisterBeanFromJson(Map<String, dynamic> json) {
  return LoginRegisterBean(
      json['id'] as int,
      json['admin'] as bool,
      (json['collectIds'] as List)?.map((e) => e as int)?.toList(),
      json['email'] as String,
      json['icon'] as String,
      json['username'] as String,
      json['nickname'] as String,
      json['password'] as String,
      json['token'] as String,
      json['type'] as int);
}

Map<String, dynamic> _$LoginRegisterBeanToJson(LoginRegisterBean instance) => <String, dynamic>{
      'admin': instance.admin,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type
    };
