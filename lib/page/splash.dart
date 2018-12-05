import 'dart:async';

import 'package:atlan_wan_android_flutter/constants.dart';
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
    Navigator.pushNamed(context, Constants.PAGE_ROUTE_HOME);
  }

}
