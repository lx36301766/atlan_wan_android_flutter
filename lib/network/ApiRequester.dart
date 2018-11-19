
import 'HttpCall.dart';
import 'HttpResponse.dart';
import 'ApiUrl.dart';

class ApiRequester {

  static void getHomeList() async {
    HttpCall.fetchGet(BASE_URL + API_HOME_LIST);
  }

}