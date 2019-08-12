
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'api_resp.dart';
import 'api_url.dart';

class DioManager {

  static final DioManager _singleton = DioManager._internal();

  factory DioManager() {
    return _singleton;
  }

  DioManager._internal();


  var _dio = Dio();

  Future<void> initialize() async {

//    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5 * 1000;
    _dio.options.sendTimeout = 5 * 1000;
    _dio.options.receiveTimeout = 3 * 1000;

    //todo 网络环境监听
//    _dio.interceptors.add(LogsInterceptors());
//    _dio.interceptors.add(WanAndroidErrorInterceptors());

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    print('http cookie path = $tempPath');
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: tempPath)));

  }

  Future fetchGet(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path + "/json";
    if (arguments != null) {
      url += "?";
      arguments.forEach((key, value) => url += "$key=$value&");
      url = url.substring(0, url.length - 1);
    }
    print("fetchGet url = $url");
    final response = await _dio.get(url);
    print("fetchGet response = $response");
    return ApiResp.fromJson(response.data).data;
  }

  Future fetchPost(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path;
    print("fetchPost1 url = $url, body=$arguments");
    final response = await _dio.post(url, data: FormData.from(arguments));
    print("fetchPost response = $response");
    return ApiResp.fromJson(response.data).data;
  }

}