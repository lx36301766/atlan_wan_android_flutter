
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:flutter/material.dart';

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

          Api.login("lx364301766", "5393147").then((resp) {
            print(resp.toString());
          }, onError: (e) {
            print(e);
          });
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

  TextEditingController _userNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  void showLoginDialog(BuildContext context) {
    NavigatorState navigator = context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
    showDialog(
        context: context,
        builder: (_) =>
            Dialog(
              backgroundColor: appMainColor,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text("登录"),
                        onPressed: () {

                        },
                      ),
                      FlatButton(
                        child: Text("注册"),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.phone),
                            labelText: '请输入你的用户名',
//                            helperText: '请输入你的用户名2',
                        ),
                        autofocus: false,
                      ),
                      TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          prefixIcon: Icon(Icons.phone),
                          labelText: '请输入密码',
//                          helperText: '请输入密码2',
                        ),
                        obscureText: true,
                      ),
                    ],
                  )
                ],
              ),
            )

//            SimpleDialog(
//                title: new Text("SimpleDialog"),
//                children: <Widget>[
//                  new SimpleDialogOption(
//                    child: new Text("SimpleDialogOption One"),
//                    onPressed: () {
//                      Navigator.of(context).pop("SimpleDialogOption One");
//                    },
//                  ),
//                  new SimpleDialogOption(
//                    child: new Text("SimpleDialogOption Two"),
//                    onPressed: () {
//                      Navigator.of(context).pop("SimpleDialogOption Two");
//                    },
//                  ),
//                  new SimpleDialogOption(
//                    child: new Text("SimpleDialogOption Three"),
//                    onPressed: () {
//                      Navigator.of(context).pop("SimpleDialogOption Three");
//                    },
//                  ),
//                ],
//            )

//            AlertDialog(
//              title: Text("atlan"),
//              content: Text("context"),
//              actions: <Widget>[
//                FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: Text("ok")
//                ),
//                FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: Text("cancel1")
//                ),
//                FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: Text("cancel")
//                ),
//              ],
//            )
    );
  }

}
