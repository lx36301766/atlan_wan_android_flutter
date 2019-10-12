// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_collect_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCollectListBean _$GetCollectListBeanFromJson(Map<String, dynamic> json) {
  return GetCollectListBean(
      json['curPage'] as int,
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : GetCollectListItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetCollectListBeanToJson(GetCollectListBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
      'datas': instance.datas
    };

GetCollectListItemBean _$GetCollectListItemBeanFromJson(
    Map<String, dynamic> json) {
  return GetCollectListItemBean(
      json['id'] as int,
      json['author'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['author'] as String),
      json['chapterId'] as int,
      json['chapterName'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['chapterName'] as String),
      json['courseId'] as int,
      json['desc'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['desc'] as String),
      json['envelopePic'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['envelopePic'] as String),
      json['link'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['link'] as String),
      json['niceDate'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['niceDate'] as String),
      json['origin'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['origin'] as String),
      json['originId'] as int,
      (json['publishTime'] as num)?.toDouble(),
      json['title'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['title'] as String),
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$GetCollectListItemBeanToJson(
        GetCollectListItemBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.author),
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.chapterName),
      'courseId': instance.courseId,
      'desc': instance.desc == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.desc),
      'envelopePic': instance.envelopePic == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.envelopePic),
      'link': instance.link == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.link),
      'niceDate': instance.niceDate == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.niceDate),
      'origin': instance.origin == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.origin),
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.title),
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };
