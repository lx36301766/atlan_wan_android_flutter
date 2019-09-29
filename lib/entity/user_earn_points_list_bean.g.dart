// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_earn_points_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEarnPointsListBean _$UserEarnPointsListBeanFromJson(Map<String, dynamic> json) {
  return UserEarnPointsListBean(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : UserEarnPointsListBeanItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$UserEarnPointsListBeanToJson(
        UserEarnPointsListBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'size': instance.size,
      'total': instance.total
    };

UserEarnPointsListBeanItem _$UserEarnPointsListBeanItemFromJson(
    Map<String, dynamic> json) {
  return UserEarnPointsListBeanItem(
      json['coinCount'] as int,
      json['date'] as int,
      json['desc'] as String,
      json['id'] as int,
      json['reason'] as String,
      json['type'] as int,
      json['userId'] as int,
      json['username'] as String);
}

Map<String, dynamic> _$UserEarnPointsListBeanItemToJson(
        UserEarnPointsListBeanItem instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'date': instance.date,
      'desc': instance.desc,
      'id': instance.id,
      'reason': instance.reason,
      'type': instance.type,
      'userId': instance.userId,
      'username': instance.username
    };
