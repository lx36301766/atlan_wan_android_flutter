import 'dart:async';

import 'package:atlan_wan_android_flutter/network/dio_manager.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _SplashPageState() {
    DioManager().initialize().then((_) {
      Future.delayed(Duration(seconds: 3), () {
        _onLogoClick();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appMainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: FlatButton(
            child: Image.asset('image/logo.png'),
            onPressed: _onLogoClick
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogoClick() async {
    Navigator.of(context).pushReplacementNamed(Pages.home);
//    ApiRequester.postLogin("lx364301766", "5393147");
  }

}
