import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/page/home.dart';
import 'package:atlan_wan_android_flutter/page/splash.dart';

import 'package:flutter/material.dart';

void main() => runApp(WanAndroidMain());

class WanAndroidMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
//      initialRoute: Constants.PAGE_ROUTE_SPLASH,
      routes: buildRoutes(),
    );
  }
}

Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    Constants.PAGE_ROUTE_SPLASH : (BuildContext context) => new SplashPage(),
    Constants.PAGE_ROUTE_HOME: (BuildContext context) => new HomePage(),
  };
}
