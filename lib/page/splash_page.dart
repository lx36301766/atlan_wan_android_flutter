import 'dart:async';

import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer _timer;

  _SplashPageState() {
    _timer = Timer(const Duration(seconds: 3), () {
//      SystemNavigator.pop();
      _onLogoClick();
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
    _timer.cancel();
  }

  void _onLogoClick() async {
    //Navigator.popAndPushNamed(context, Pages.home);
    Navigator.of(context).pushReplacementNamed(Pages.home);
  }

}
