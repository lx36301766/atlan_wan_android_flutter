// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_point_leaderboard_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointLeaderboardBean _$UserPointLeaderboardBeanFromJson(
    Map<String, dynamic> json) {
  return UserPointLeaderboardBean(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : UserPointBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$UserPointLeaderboardBeanToJson(
        UserPointLeaderboardBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'size': instance.size,
      'total': instance.total
    };
