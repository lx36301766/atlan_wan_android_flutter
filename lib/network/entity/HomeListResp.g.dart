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
      json['total'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null
              ? null
              : HomeListDataBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
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

HomeListDataBean _$HomeListDataBeanFromJson(Map<String, dynamic> json) {
  return HomeListDataBean(
      json['apkLink'] as String,
      json['author'] as String,
      json['chapterId'] as int,
      json['chapterName'] as String,
      json['collect'] as bool,
      json['courseId'] as int,
      json['desc'] as String,
      json['envelopePic'] as String,
      json['fresh'] as bool,
      json['id'] as int,
      json['link'] as String,
      json['niceDate'] as String,
      json['origin'] as String,
      json['projectLink'] as String,
      (json['publishTime'] as num)?.toDouble(),
      json['superChapterId'] as int,
      json['superChapterName'] as String,
      (json['tags'] as List)
          ?.map((e) => e == null
              ? null
              : HomeListDataTagBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['title'] as String,
      json['type'] as int,
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$HomeListDataBeanToJson(HomeListDataBean instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };

HomeListDataTagBean _$HomeListDataTagBeanFromJson(Map<String, dynamic> json) {
  return HomeListDataTagBean(json['name'] as String, json['url'] as String);
}

Map<String, dynamic> _$HomeListDataTagBeanToJson(
        HomeListDataTagBean instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
