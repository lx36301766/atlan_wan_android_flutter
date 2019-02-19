import 'package:atlan_wan_android_flutter/page/main_page.dart';
import 'package:atlan_wan_android_flutter/page/splash_page.dart';
import 'package:atlan_wan_android_flutter/page/web_view_page.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    Pages.splash : (BuildContext context) => new SplashPage(),
    Pages.home: (BuildContext context) => new MainPage(),
    Pages.webView: (BuildContext context) => new WebViewPage(),
  };
}


class Pages {

  static final splash = '/splash';
  static final home = '/home';
  static final webView = '/webView';

  static void openWebView(BuildContext context, String url) {
//    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//      return WebViewPage(url: url);
//    }));
    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return WebViewPage(url: url);
    }, 
    // transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
    //   return FadeTransition(
    //     opacity: animation,
    //     child: RotationTransition(
    //       turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
    //     ),
    //   );
    // }
    ));
  }

}
