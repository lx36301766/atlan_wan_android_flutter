
import 'package:atlan_wan_android_flutter/util/unescape_json_convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_collect_list_bean.g.dart';

@JsonSerializable()
@UnescapeJsonConvert()
class GetCollectListBean {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<GetCollectListItemBean> datas;

  GetCollectListBean(this.curPage, this.offset, this.over, this.pageCount, this.size, this.total, this.datas);

  factory GetCollectListBean.fromJson(Map<String, dynamic> json) => _$GetCollectListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GetCollectListBeanToJson(this);

}

@JsonSerializable()
@UnescapeJsonConvert()
class GetCollectListItemBean {

  int id;
  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String desc;
  String envelopePic;
  String link;
  String niceDate;
  String origin;
  int originId;
  double publishTime;
  String title;
  int userId;
  int visible;
  int zan;

  GetCollectListItemBean(this.id, this.author, this.chapterId, this.chapterName, this.courseId,this.desc,
      this.envelopePic, this.link, this.niceDate, this.origin, this.originId, this.publishTime, this.title,
      this.userId, this.visible, this.zan);

  factory GetCollectListItemBean.fromJson(Map<String, dynamic> json) => _$GetCollectListItemBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GetCollectListItemBeanToJson(this);

}