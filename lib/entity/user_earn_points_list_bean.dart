
import 'package:json_annotation/json_annotation.dart';

part 'user_earn_points_list_bean.g.dart';

@JsonSerializable()
class UserEarnPointsListBean {

  int curPage;
  List<UserEarnPointsListBeanItem> datas;
  int offset;
  bool over;
  int size;
  int total;

  UserEarnPointsListBean(this.curPage, this.datas, this.offset, this.over, this.size, this.total);

  factory UserEarnPointsListBean.fromJson(Map<String, dynamic> json) => _$UserEarnPointsListBeanFromJson(json);

  Map<String, dynamic> toJson(UserEarnPointsListBean instance) => _$UserEarnPointsListBeanToJson(instance);

}

@JsonSerializable()
class UserEarnPointsListBeanItem {

  int coinCount;
  int date;
  String desc;
  int id;
  String reason;
  int type;
  int userId;
  String username;

  UserEarnPointsListBeanItem(this.coinCount, this.date, this.desc, this.id, this.reason, this.type, this.userId,
      this.username);

  factory UserEarnPointsListBeanItem.fromJson(Map<String, dynamic> json) => _$UserEarnPointsListBeanItemFromJson(json);

  Map<String, dynamic> toJson(UserEarnPointsListBeanItem instance) => _$UserEarnPointsListBeanItemToJson(instance);

}
