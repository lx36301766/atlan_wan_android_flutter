import 'package:atlan_wan_android_flutter/bloc/bloc_provider.dart';
import 'package:atlan_wan_android_flutter/bloc/login_bloc.dart';
import 'package:atlan_wan_android_flutter/entity/login_register_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/util/storage_utils.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'after_layout.dart';
import 'login_dialog.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> with AfterLayoutMixin<DrawerView> {
  LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    var loginBean = StorageUtils.getUserInfo();
    bloc.setLoginRegisterBean(loginBean);
    if (loginBean != null) {
      bloc.getUserPoint();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header = DrawerHeader(
      margin: EdgeInsets.only(top: 10),
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 1000),
      child: FlatButton(
        onPressed: () {
          if (StorageUtils.getUserInfo() != null) {
            showLogoutDialog(context);
          } else {
            showLoginDialog(context);
          }
        },
//        splashColor: Color(0x00FFFF0F),
//        highlightColor: Color(0x00FF0FFF),
        child: StreamBuilder<LoginRegisterBean>(
            stream: bloc.loginRegisterValue,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      radius: 30,
                      child: snapshot.hasData ?
                      ClipOval(
                        child: Image.asset('image/avater.png',
                          fit: BoxFit.cover,
                        ),
                      ) : Icon(
                        Icons.person_pin_circle,
                        color: appMainColor,
                      ),
                      backgroundColor: Colors.tealAccent.shade100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(snapshot.hasData ? snapshot.data.nickname : "登录"),
                  ),
                  StreamBuilder<UserPointBean>(
                      stream: bloc.userPointValue,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () => {
                              Pages.openPointDetailPage(context, null)
                            },
                            child: Text("积分: ${snapshot.hasData ? snapshot.data.coinCount : 0}",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            }),
      ),
    );

    ListView list = ListView(
      children: <Widget>[
        header,
//        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: ListTile(
            leading: Icon(Icons.web, color: appMainColor),
            title: Text("常用网站"),
            onTap: () {},
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.collections, color: appMainColor),
          title: Text("收藏"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.toc, color: appMainColor),
          title: Text("TODO"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings, color: appMainColor),
          title: Text("设置"),
          onTap: () {},
        ),
        Divider(),
        AboutListTile(
          icon: Icon(Icons.info_outline, color: appMainColor),
          child: Text("关于"),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: list,
//            child: NotificationListener<OverscrollIndicatorNotification>(
//              onNotification: (overscroll) {
//                overscroll.disallowGlow();
//              },
//              child: list,
//            ),
          )
        ],
      ),
    );
  }

  void showLoginDialog(BuildContext context) async {
    await showDialog(context: context, builder: (_) => LoginDialog());
  }

  void showLogoutDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                content: Text("是否退出登录？"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("否"),
                    highlightColor: appMainColor,
                    textColor: Colors.black54,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("是"),
                    splashColor: appMainColor,
                    textColor: Colors.black54,
                    onPressed: () {
                      Navigator.of(context).pop();
                      bloc.logout();
                    },
                  )
                ]));
  }
}
