import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/page/home.dart';
import 'package:atlan_wan_android_flutter/page/splash.dart';
import 'package:atlan_wan_android_flutter/pages.dart';

import 'package:flutter/material.dart';

void main() => runApp(WanAndroidMain());

class WanAndroidMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
      initialRoute: Pages.ROUTE_SPLASH,
      routes: {
        Pages.ROUTE_SPLASH : (BuildContext context) => new SplashPage(),
        Pages.ROUTE_HOME: (BuildContext context) => new HomePage(),
      },
    );
  }
}

Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    Pages.ROUTE_SPLASH : (BuildContext context) => new SplashPage(),
    Pages.ROUTE_HOME: (BuildContext context) => new HomePage(),
  };
}
