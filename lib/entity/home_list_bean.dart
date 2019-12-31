
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

import 'get_collect_list_bean.dart';

part 'home_list_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class HomeListBean {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<HomeListDataBean> datas;

  HomeListBean(this.curPage, this.offset, this.over, this.pageCount, this.size, this.total, this.datas);

  HomeListBean.formCollectList(GetCollectListBean collectListBean) {
    this.curPage = collectListBean.curPage;
    this.offset = collectListBean.offset;
    this.over = collectListBean.over;
    this.pageCount = collectListBean.pageCount;
    this.size = collectListBean.size;
    this.total = collectListBean.total;
    this.datas = collectListBean.datas.map((collectItem) => HomeListDataBean.formCollectItem(collectItem)).toList();
  }

  factory HomeListBean.fromJson(Map<String, dynamic> json) => _$HomeListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListBeanToJson(this);

  @override
  String toString() {
    return 'HomeListResp{curPage: $curPage, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total, datas: $datas}';
  }

}

@JsonSerializable()
@UnescapeJsonConvert()
class HomeListDataBean {

  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  double publishTime;
  int selfVisible;
  double shareDate;
  String shareUser;
  int superChapterId;
  String superChapterName;
  List<HomeListDataTagBean> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;


  HomeListDataBean(
      this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.publishTime,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  HomeListDataBean.formCollectItem(GetCollectListItemBean itemBean) {
    this.id = itemBean.originId;
    this.author = itemBean.author;
    this.chapterId = itemBean.chapterId;
    this.chapterName = itemBean.chapterName;
    this.courseId = itemBean.courseId;
    this.desc = itemBean.desc;
    this.envelopePic = itemBean.envelopePic;
    this.link = itemBean.link;
    this.niceDate = itemBean.niceDate;
    this.origin = itemBean.origin;
//    this.originId = itemBean.originId;
    this.publishTime = itemBean.publishTime;
    this.title = itemBean.title;
    this.userId = itemBean.userId;
    this.visible = itemBean.visible;
    this.zan = itemBean.zan;

  }

  factory HomeListDataBean.fromJson(Map<String, dynamic> json) => _$HomeListDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListDataBeanToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HomeListDataBean &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

}


@JsonSerializable()
@UnescapeJsonConvert()
class HomeListDataTagBean {

  String name;
  String url;

  HomeListDataTagBean(this.name, this.url);

  factory HomeListDataTagBean.fromJson(Map<String, dynamic> json) => _$HomeListDataTagBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListDataTagBeanToJson(this);

}
