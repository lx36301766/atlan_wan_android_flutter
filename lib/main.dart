import 'package:flutter/material.dart';
import 'package:atlan_wan_android_flutter/page/splash.dart';

void main() => runApp(WanAndroidMain());

class WanAndroidMain extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlan WanAndroid',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
    );
  }
}
