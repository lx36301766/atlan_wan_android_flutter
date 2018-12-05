
class ApiResp {

  var data;

  int errorCode;

  String errorMsg;

  ApiResp(this.data, this.errorCode, this.errorMsg);

  factory ApiResp.fromJson(Map<String, dynamic> json) {
    return ApiResp(
      json['data'],
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
