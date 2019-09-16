
import 'package:json_annotation/json_annotation.dart';

part 'user_point_get_list_bean.g.dart';

@JsonSerializable()
class UserPointGetListBean {

  int curPage;
  List<UserPointGetListBeanItem> datas;
  int offset;
  bool over;
  int size;
  int total;

  UserPointGetListBean(this.curPage, this.datas, this.offset, this.over, this.size, this.total);

  factory UserPointGetListBean.fromJson(Map<String, dynamic> json) => _$UserPointGetListBeanFromJson(json);

  Map<String, dynamic> toJson(UserPointGetListBean instance) => _$UserPointGetListBeanToJson(instance);

}

@JsonSerializable()
class UserPointGetListBeanItem {

  int coinCount;
  int date;
  String desc;
  int id;
  String reason;
  int type;
  int userId;
  String username;

  UserPointGetListBeanItem(this.coinCount, this.date, this.desc, this.id, this.reason, this.type, this.userId,
      this.username);

  factory UserPointGetListBeanItem.fromJson(Map<String, dynamic> json) => _$UserPointGetListBeanItemFromJson(json);

  Map<String, dynamic> toJson(UserPointGetListBeanItem instance) => _$UserPointGetListBeanItemToJson(instance);

}
