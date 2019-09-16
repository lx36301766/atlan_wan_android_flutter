import 'dart:convert';

import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String KEY_USER_INFO = "user_info";

class StorageUtils {

  static SharedPreferences sharedPreferences;

  static Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic get(String key) {
    var value = sharedPreferences.get(key);
    print("StorageUtils.get, key=$key, value=$value");
    return value;
  }

  static void set(String key, dynamic value) {
    print("StorageUtils.set, key=$key, value=$value");
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    }
  }

  static LoginRegisterBean getUserInfo() => LoginRegisterBean.fromJson(json.decode(get(KEY_USER_INFO)));

  static void setUserInfo(LoginRegisterBean bean) => set(KEY_USER_INFO, json.encode(bean.toJson()));

}
