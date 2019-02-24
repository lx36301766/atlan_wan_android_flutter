import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/page/splash_page.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';

import 'package:flutter/material.dart';

void main() => runApp(AtlanWanAndroid());

class AtlanWanAndroid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        //how-to-remove-scroll-glow：
        //https://stackoverflow.com/questions/50899640/how-to-remove-listview-highlight-color-in-flutter
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
      initialRoute: Pages.splash,
      routes: buildRoutes(),
    );
  }
}

class MyBehavior extends ScrollBehavior {

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}