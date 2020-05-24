
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/page/general_article_list_page.dart';
import 'package:atlan_wan_android_flutter/page/google_maven_page.dart';
import 'package:atlan_wan_android_flutter/page/main_page.dart';
import 'package:atlan_wan_android_flutter/page/point_details_page.dart';
import 'package:atlan_wan_android_flutter/page/search_page.dart';
import 'package:atlan_wan_android_flutter/page/setting_page.dart';
import 'package:atlan_wan_android_flutter/page/splash_page.dart';
import 'package:atlan_wan_android_flutter/page/todo_page.dart';
import 'package:atlan_wan_android_flutter/page/web_view_page.dart';
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
        return WebViewPage(title: title, url: url.replaceAll("http:", "https:"));
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

  static void openSearchPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return ScopedModel(
            model: SearchKeyModel(),
            child: SearchPage()
        );
      },
    ));
  }

  static void openSearchResultListPage(BuildContext context, String key, [Function callback]) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return WillPopScope(
          onWillPop: () {
            return Future(() {
              callback();
              return true;
            });
          },
          child: ScopedModel(
              model: SearchResultModel(key),
              child: GeneralArticleListPage<SearchResultModel>()
          ),
        );
      },
    ));
  }

  static void openClassificationList(BuildContext context, KnowledgeSystemBean bean) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return ScopedModel(
          model: ClassificationModel(bean.name, bean.id),
          child: GeneralArticleListPage<ClassificationModel>()
        );
      },
    ));
  }

  static void openCollectListPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return ScopedModel(
            model: MineCollectModel(),
            child: GeneralArticleListPage<MineCollectModel>()
        );
      },
    ));
  }

  static void openUserArticleListPage(BuildContext context, String author, [int shareUserId = -1]) {
    if (shareUserId == -1) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return ScopedModel(
              model: AuthorArticleListModel(author),
              child: GeneralArticleListPage<AuthorArticleListModel>()
          );
        },
      ));
    } else {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return ScopedModel(
              model: ShareUserArticleListModel(shareUserId, author),
              child: GeneralArticleListPage<ShareUserArticleListModel>()
          );
        },
      ));
    }
  }

  static void openMyShareListPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return ScopedModel(
            model: MyShareArticleListModel(),
            child: GeneralArticleListPage<MyShareArticleListModel>()
        );
      },
    ));
  }

  static void openPointDetailPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return PointDetailsList();
      },
    ));
  }

  static void openSettingPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return SettingPage();
      },
    ));
  }

  static void openTodoPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return TodoPage();
      },
    ));
  }

  static void openGoogleMavenPage(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return GoogleMavenPage();
      },
    ));
  }

}
