// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeListBean _$HomeListBeanFromJson(Map<String, dynamic> json) {
  return HomeListBean(
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

Map<String, dynamic> _$HomeListBeanToJson(HomeListBean instance) =>
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
      json['apkLink'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['apkLink'] as String),
      json['author'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['author'] as String),
      json['chapterId'] as int,
      json['chapterName'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['chapterName'] as String),
      json['collect'] as bool,
      json['courseId'] as int,
      json['desc'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['desc'] as String),
      json['envelopePic'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['envelopePic'] as String),
      json['fresh'] as bool,
      json['id'] as int,
      json['link'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['link'] as String),
      json['niceDate'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['niceDate'] as String),
      json['origin'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['origin'] as String),
      json['projectLink'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['projectLink'] as String),
      (json['publishTime'] as num)?.toDouble(),
      json['superChapterId'] as int,
      json['superChapterName'] == null
          ? null
          : const UnescapeJsonConvert()
              .fromJson(json['superChapterName'] as String),
      (json['tags'] as List)
          ?.map((e) => e == null
              ? null
              : HomeListDataTagBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['title'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['title'] as String),
      json['type'] as int,
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$HomeListDataBeanToJson(HomeListDataBean instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.apkLink),
      'author': instance.author == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.author),
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.chapterName),
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.desc),
      'envelopePic': instance.envelopePic == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.envelopePic),
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.link),
      'niceDate': instance.niceDate == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.niceDate),
      'origin': instance.origin == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.origin),
      'projectLink': instance.projectLink == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.projectLink),
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.superChapterName),
      'tags': instance.tags,
      'title': instance.title == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.title),
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };

HomeListDataTagBean _$HomeListDataTagBeanFromJson(Map<String, dynamic> json) {
  return HomeListDataTagBean(
      json['name'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['name'] as String),
      json['url'] == null
          ? null
          : const UnescapeJsonConvert().fromJson(json['url'] as String));
}

Map<String, dynamic> _$HomeListDataTagBeanToJson(
        HomeListDataTagBean instance) =>
    <String, dynamic>{
      'name': instance.name == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.name),
      'url': instance.url == null
          ? null
          : const UnescapeJsonConvert().toJson(instance.url)
    };
