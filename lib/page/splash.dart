import 'package:flutter/material.dart';

class WanAndroidApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlan WanAndroid',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Widget image = new Image.asset(
      'image/logo.png',
      width: 100.0,
      height: 100.0,
      // fit: BoxFit.fill,
    );
    return image;
  }
}
