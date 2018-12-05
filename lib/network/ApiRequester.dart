
import 'package:atlan_wan_android_flutter/network/ApiResp.dart';
import 'package:atlan_wan_android_flutter/network/entity/HomeListResp2.dart';

import 'HttpCall.dart';
import 'ApiUrl.dart';


class ApiRequester {

  static Future getHomeList(int page) async {
    return HttpCall.fetchGet(BASE_URL + API_HOME_LIST + page.toString() + "/json");
  }

}


void main() {
  ApiRequester.getHomeList(1).then((map){
    print(ApiResp<HomeListResp2>.fromJson(map).data.toString());
  }, onError: (e) {
    print(e);
  });
}
