// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_point_get_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPointGetListBean _$UserPointGetListBeanFromJson(Map<String, dynamic> json) {
  return UserPointGetListBean(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : UserPointGetListBeanItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$UserPointGetListBeanToJson(
        UserPointGetListBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'size': instance.size,
      'total': instance.total
    };

UserPointGetListBeanItem _$UserPointGetListBeanItemFromJson(
    Map<String, dynamic> json) {
  return UserPointGetListBeanItem(
      json['coinCount'] as int,
      json['date'] as int,
      json['desc'] as String,
      json['id'] as int,
      json['reason'] as String,
      json['type'] as int,
      json['userId'] as int,
      json['username'] as String);
}

Map<String, dynamic> _$UserPointGetListBeanItemToJson(
        UserPointGetListBeanItem instance) =>
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
