

import 'package:atlan_wan_android_flutter/network/entity/HomeListResp.dart';

class ApiResp<T> {

  T data;

  int errorCode;

  String errorMsg;

  ApiResp(this.data, this.errorCode, this.errorMsg);

  factory ApiResp.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    if (T == HomeListResp) {
      data = HomeListResp.fromJson(data);
    }
    return ApiResp(data,
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'errorCode': errorCode,
    'errorMsg': errorMsg,
  };

}
