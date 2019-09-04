
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_dialog.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {

    Widget header = DrawerHeader(
      margin: EdgeInsets.only(top: 10),
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 1000),
      child: FlatButton(
        onPressed: () {

          showLoginDialog(context);
//          Pages.openLoginPage(context);

//          Api.login("lx364301766", "5393147").then((resp) {
//            print(resp.toString());
//          }, onError: (e) {
//            print(e);
//          });
        },
//        splashColor: Color(0x00FFFF0F),
//        highlightColor: Color(0x00FF0FFF),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:20),
              child: CircleAvatar(
                child: Icon(Icons.person_pin_circle,
                  color: appMainColor,
                ),
                backgroundColor: Colors.tealAccent.shade100,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('登录'),
            ),
          ],
        ),
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
          onTap: () {
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings, color: appMainColor),
          title: Text("设置"),
          onTap: () {

          },
        ),
        Divider(),
        AboutListTile(
          icon: Icon(Icons.info_outline, color: appMainColor),
          child: Text("关于"),
        ),
      ],
    );

    return Container(
//      color: Colors.blue,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: <Widget>[
//          Expanded(
//            child: header,
//          ),
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
    await showDialog(
        context: context,
        builder: (_) =>
            BlocProvider(
                builder: (BuildContext context) => LoginBloc(),
                child: LoginDialog()
            )
    );
  }

}
