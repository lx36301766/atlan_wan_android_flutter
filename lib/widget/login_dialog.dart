import 'package:atlan_wan_android_flutter/bloc/bloc_provider.dart';
import 'package:atlan_wan_android_flutter/bloc/login_bloc.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_dialog.dart';

class LoginDialog extends StatefulWidget {

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    print("_LoginDialogState initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_LoginDialogState didChangeDependencies");
  }

  @override
  void didUpdateWidget(LoginDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_LoginDialogState didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("_LoginDialogState dispose");
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<LoginBloc>(context);
    return CustomDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: StreamBuilder<bool>(
            initialData: false,
            stream: bloc.isRegisterValue,
            builder: (context, snapshot) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: FlatButton(
                          child: Text(
                            "登录",
                            style: TextStyle(color: snapshot.data ? Colors.black : appMainColor),
                          ),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(_userNameFocusNode);
                            bloc.setIsRegister(false);
                          },
                        ),
                      ),
                      Flexible(
                        child: FlatButton(
                          child: Text(
                            "注册",
                            style: TextStyle(color: snapshot.data ? appMainColor : Colors.black),
                          ),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(_userNameFocusNode);
                            bloc.setIsRegister(true);
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        focusNode: _userNameFocusNode,
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          prefixIcon: Icon(FontAwesomeIcons.user),
                          hintText: '请输入用户名',
                        ),
                        autofocus: false,
                      ),
                      TextField(
                        focusNode: _passwordFocusNode,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                          hintText: '请输入密码',
                        ),
                        obscureText: true,
                      ),
                      Visibility(
                        visible: snapshot.data,
                        child: TextField(
                          controller: _repasswordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            prefixIcon: Icon(FontAwesomeIcons.lock),
                            hintText: '确认密码',
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: FlatButton(
                        color: appMainColor,
                        splashColor: appMainColor,
                        onPressed: () {
                          var userName = _userNameController.text.trim();
                          var password = _passwordController.text.trim();
                          var repassword = _repasswordController.text.trim();
                          if (snapshot.data) {
                            bloc.register(userName, password, repassword).then((resp) {
//                              ToastUtil.show("注册成功,请登录");
                              print( "resp = $resp");
                              FocusScope.of(context).requestFocus(_userNameFocusNode);
                            });
                          } else {
                            bloc.login(userName, password).then((resp) {
                              ToastUtil.show("登录成功");
                              Navigator.pop(context);
                            }, onError: (e) {
                              print(e);
                            });
                          }
                        },
                        child: Text("确认"),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
