import 'dart:async';

import 'package:atlan_wan_android_flutter/network/dio_manager.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:flutter/material.dart';


/// 用于项目初始化之前显示的页面
class SplashImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,//背景色
      child: Image.asset('image/logo.png',
        fit: BoxFit.fill,
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _SplashPageState() {
    Future.delayed(Duration(seconds: 3), _onLogoClick);
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

  void _onLogoClick() {
    Navigator.of(context).pushReplacementNamed(Pages.home);
//    ApiRequester.postLogin("lx364301766", "5393147");
  }

}
