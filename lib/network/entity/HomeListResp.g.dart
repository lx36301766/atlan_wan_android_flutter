// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeListResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListResp _$HomeListRespFromJson(Map<String, dynamic> json) {
  return HomeListResp(
      json['curPage'] as int,
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int)
    ..datas = json['datas'] as List;
}

Map<String, dynamic> _$HomeListRespToJson(HomeListResp instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
      'datas': instance.datas
    };
