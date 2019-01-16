import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/page/main.dart';
import 'package:atlan_wan_android_flutter/page/splash.dart';
import 'package:atlan_wan_android_flutter/pages.dart';

import 'package:flutter/material.dart';

void main() => runApp(AtlanWanAndroid());

class AtlanWanAndroid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
      initialRoute: Pages.splash,
      routes: {
        Pages.splash : (BuildContext context) => new SplashPage(),
        Pages.home: (BuildContext context) => new MainPage(),
      },
    );
  }
}

Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    Pages.splash : (BuildContext context) => new SplashPage(),
    Pages.home: (BuildContext context) => new MainPage(),
  };
}
