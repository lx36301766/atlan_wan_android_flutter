import 'dart:io';

import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/page/splash_page.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/login_bloc.dart';
import 'network/api_network.dart';
import 'util/storage_utils.dart';

//void main() => runApp(AtlanWanAndroid());

void main() {

  runApp(AtlanWanAndroid());

   //判断如果是Android版本的话 设置Android状态栏透明沉浸式
 if(Platform.isAndroid){
   //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
 }
}

class AtlanWanAndroid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appInitialize(),
      builder: (context, snapshot) {
        /// 在异步操作时,显示的页面
        if (snapshot.connectionState != ConnectionState.done) {
          return SplashImage();
        }
        return BlocProvider(
          bloc: LoginBloc(),
          child: OKToast(
            dismissOtherOnShow: true,
            child: MaterialApp(
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
//        primarySwatch: Colors.blue,
                primaryColor: appMainColor,
              ),
              // initialRoute 名字必须为 '/'，不然要报错
              initialRoute: Pages.splash,
              routes: buildRoutes(),
            ),
          ),
        );
      }
    );
  }

  Future<void> appInitialize() async {
    ApiNetwork().initialize();
    StorageUtils.initialize();
  }

}

class MyBehavior extends ScrollBehavior {

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}