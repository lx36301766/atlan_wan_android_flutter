
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

  List datas;

  HomeListResp(this.curPage, this.offset, this.over, this.pageCount, this.size, this.total);

  factory HomeListResp.fromJson(Map<String, dynamic> json) => _$HomeListRespFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListRespToJson(this);

}
