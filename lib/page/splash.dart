import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

// class _SplashPageState extends State<SplashPage> {
//   @override
//   Widget build(BuildContext context) {
//     Widget image = new Image.asset(
//       'image/logo.png',
//       width: 100.0,
//       height: 100.0,
//       // fit: BoxFit.fill,
//     );
//     return image;
//   }
// }

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.orange,
      body: new Center(
         child: new Image.asset('image/logo.png'),
        ),
    );
  }

}
