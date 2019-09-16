

import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {

  static show(String msg) {
//    Fluttertoast.showToast(
//      msg: msg,
//      toastLength: Toast.LENGTH_LONG,
//      backgroundColor: appMainColor,
//      textColor: Colors.black54,
//    );
    showToast(
      msg,
      duration: Duration(seconds: 3),
      position: ToastPosition.bottom,
      backgroundColor: appMainColor.withAlpha(196),
    );
  }

}
