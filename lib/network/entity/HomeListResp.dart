
import 'package:json_annotation/json_annotation.dart';

part 'HomeListResp.g.dart';

@JsonSerializable()
class HomeListResp {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<HomeListDataBean> datas;

  HomeListResp(this.curPage, this.offset, this.over, this.pageCount, this.size, this.total, this.datas);

  factory HomeListResp.fromJson(Map<String, dynamic> json) => _$HomeListRespFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListRespToJson(this);

  @override
  String toString() {
    return 'HomeListResp{curPage: $curPage, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total, datas: $datas}';
  }

}

@JsonSerializable()
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
  int superChapterId;
  String superChapterName;
  List<HomeListDataTagBean> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;


  HomeListDataBean(this.apkLink, this.author, this.chapterId, this.chapterName, this.collect, this.courseId, this.desc,
      this.envelopePic, this.fresh, this.id, this.link, this.niceDate, this.origin, this.projectLink, this.publishTime,
      this.superChapterId, this.superChapterName, this.tags, this.title, this.type, this.userId, this.visible,
      this.zan);

  factory HomeListDataBean.fromJson(Map<String, dynamic> json) => _$HomeListDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListDataBeanToJson(this);

}


@JsonSerializable()
class HomeListDataTagBean {

  String name;
  String url;

  HomeListDataTagBean(this.name, this.url);

  factory HomeListDataTagBean.fromJson(Map<String, dynamic> json) => _$HomeListDataTagBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListDataTagBeanToJson(this);


}
