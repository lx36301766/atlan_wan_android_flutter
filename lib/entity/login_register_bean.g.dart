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
      json['email'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['email'] as String),
      json['icon'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['icon'] as String),
      json['username'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['username'] as String),
      json['nickname'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['nickname'] as String),
      json['password'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['password'] as String),
      json['token'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['token'] as String),
      json['type'] as int);
}

Map<String, dynamic> _$LoginRegisterBeanToJson(LoginRegisterBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'admin': instance.admin,
      'collectIds': instance.collectIds,
      'email': instance.email == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.email),
      'icon': instance.icon == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.icon),
      'username': instance.username == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.username),
      'nickname': instance.nickname == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.nickname),
      'password': instance.password == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.password),
      'token': instance.token == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.token),
      'type': instance.type
    };
