
import 'dart:convert';
import 'dart:io';

import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import 'api_resp.dart';
import 'api_url.dart';

class ApiError extends Error {

  final String message;

  ApiError(this.message);

  String toString() => "ApiError: $message";
}



abstract class ApiNetwork {

  static const network = 2;

  factory ApiNetwork() {
    if (network == 1) {
      return _HttpNetwork();
    } else if (network == 2) {
      return _DioNetwork();
    } else {
      return null;
    }
  }

  ApiNetwork._internal();

  Future<void> initialize();

  Future fetchGet(String path, [Map<String, String> arguments]);

  Future fetchPost(String path, [Map<String, String> arguments]);

  ApiResp _parseErrorCode(Map<String, dynamic> json) {
    var resp = ApiResp.fromJson(json);
    if (resp.errorCode != 0) {
      ToastUtil.show(resp.errorMsg);
    }
    return resp;
  }

}


class _HttpNetwork extends ApiNetwork {

  static final _HttpNetwork _singleton = _HttpNetwork._internal();

  factory _HttpNetwork() => _singleton;

  _HttpNetwork._internal(): super._internal();

  @override
  Future<void> initialize() async {

  }

  Future fetchGet(String path, [ Map<String, String> arguments ] ) async {
    // var url = baseUrl + path + "/json";
    // if (arguments != null) {
    //   url += "?";
    //   arguments.forEach((key, value) => url += "$key=$value&");
    //   url = url.substring(0, url.length - 1);
    // }
    print("fetchGet path = $path");
    path = path + "/json";
    final response = await http.get(Uri.https(baseUrl, path, arguments));
    var map = json.decode(response.body);
    return ApiResp.fromJson(map).data;
  }

  Future fetchPost(String path, [ Map<String, String> arguments ] ) async {
    print("fetchPost path = $path, body=$arguments");
    final response = await http.post(Uri.https(baseUrl, path, arguments), body: arguments);
    var map = json.decode(response.body);
    return ApiResp.fromJson(map).data;
  }

}


class _DioNetwork extends ApiNetwork {

  static final _DioNetwork _singleton = _DioNetwork._internal();

  factory _DioNetwork() => _singleton;

  _DioNetwork._internal(): super._internal();

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

    var cookJar = PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath));
    List<Cookie> cookies = await cookJar.loadForRequest(Uri.parse(baseUrl + apiLogin));
    cookies.forEach((cookie) {
      print('cookie = $cookie');
    });
    _dio.interceptors.add(CookieManager(cookJar));

//    assert(() {
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//        // config the http client
//        client.findProxy = (uri) {
//          //proxy all request to localhost:8888
//          return "PROXY 192.168.1.188:8888";
//        };
//        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
//          return true;
//        };
//      };
//      return true;
//    }());
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
    return _parseErrorCode(response.data).data;
  }

  Future fetchPost(String path, [ Map<String, String> arguments ] ) async {
    var url = baseUrl + path;
    print("fetchPost url = $url, body=$arguments");
    var data = arguments == null ? FormData() : FormData.fromMap(arguments);
    final response = await _dio.post(url, data: data);
    print("fetchPost response = $response");
    return _parseErrorCode(response.data).data;
  }

//  Future fetchPost(String path, [ Map<String, String> arguments ] ) async {
//    var url = baseUrl + path;
//    print("fetchPost url = $url, body=$arguments");
//    var data = arguments == null ? FormData() : FormData.from(arguments);
//    final response = await _dio.post(url, queryParameters: arguments);
//    print("fetchPost response = $response");
//    return _parseErrorCode(response.data).data;
//  }

}