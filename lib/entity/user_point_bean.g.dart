// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_point_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointBean _$UserPointBeanFromJson(Map<String, dynamic> json) {
  return UserPointBean(
      json['coinCount'] as int,
      json['rank'] as int,
      json['userId'] as int,
      json['username'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['username'] as String));
}

Map<String, dynamic> _$UserPointBeanToJson(UserPointBean instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.username)
    };
