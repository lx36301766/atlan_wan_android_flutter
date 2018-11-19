
import 'package:json_annotation/json_annotation.dart';

part 'HomeListResp.g.dart';

@JsonSerializable()

class HomeListResp {

  int curPage;

  String name;

  HomeListResp(this.curPage, this.name);

  factory HomeListResp.fromJson(Map<String, dynamic> json) => _$HomeListRespFromJson(json);

  Map<String, dynamic> toJson() => _$HomeListRespToJson(this);

}
