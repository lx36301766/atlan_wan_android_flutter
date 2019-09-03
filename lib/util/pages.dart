
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/page/login_page.dart';
import 'package:atlan_wan_android_flutter/page/classification_list_page.dart';
import 'package:atlan_wan_android_flutter/page/main_page.dart';
import 'package:atlan_wan_android_flutter/page/splash_page.dart';
import 'package:atlan_wan_android_flutter/page/web_view_page2.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return <String, WidgetBuilder>{
    Pages.splash: (BuildContext context) => SplashPage(),
    Pages.home: (BuildContext context) => MainPage(),
    Pages.webView: (BuildContext context) => WebViewPage2(),
//    Pages.classificationList: (BuildContext context) => ClassificationListPage(),
  };
}

class Pages {
  Pages._();

  static final splash = '/';
  static final home = '/home';
  static final webView = '/webView';
  static final classificationList = '/classificationList';

  static void openWebView(BuildContext context, String title, String url) {
//    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//      return WebViewPage(url: url);
//    }));
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return WebViewPage2(title: title, url: url);
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

  static void openClassificationList(BuildContext context, KnowledgeSystemBean bean) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return ScopedModel(
          model: ClassificationModel(bean),
          child: ClassificationListPage()
        );
      },
    ));
  }

  static void openLoginPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return LoginPage();
      },
    ));
  }

}
