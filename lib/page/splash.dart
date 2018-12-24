import 'dart:async';

import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer _timer;

  _SplashPageState() {
    _timer = Timer(const Duration(seconds: 1), () {
//      SystemNavigator.pop();
      _onLogoClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: FlatButton(
          child: Image.asset('image/logo.png'),
          onPressed: _onLogoClick
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _onLogoClick() {
    Navigator.pushNamed(context, Pages.ROUTE_HOME);
//    ApiRequester.getHomeList(1).then((resp){
//      print(resp.toString());
//    }, onError: (e) {
//      print(e);
//    });
//
//
//    ApiRequester.getHomeBanner().then((resp){
//      print(resp.toString());
//    }, onError: (e) {
//      print(e);
//    });
//
//    ApiRequester.getHomeCommonWebsite().then((resp){
//      print(resp.toString());
//    }, onError: (e) {
//      print(e);
//    });
//
//    ApiRequester.getHomeHotKey().then((resp){
//      print(resp.toString());
//    }, onError: (e) {
//      print(e);
//    });

  }

}
