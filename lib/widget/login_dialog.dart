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

  bool _isRegister = false;

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical:5, horizontal:18),
          child: Column(
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
                        style: TextStyle(color: _isRegister ? Colors.black : appMainColor),
                      ),
                      onPressed: () {
                        setState(() {
                          _isRegister = false;
                          FocusScope.of(context).requestFocus(_userNameFocusNode);
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: FlatButton(
                      child: Text(
                        "注册",
                        style: TextStyle(color: _isRegister ? appMainColor : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _isRegister = true;
                          FocusScope.of(context).requestFocus(_userNameFocusNode);
                        });
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
                      labelText: '请输入用户名',
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
                      labelText: '请输入密码',
                    ),
                    obscureText: true,
                  ),
                  Visibility(
                    visible: _isRegister,
                    child: TextField(
                      controller: _repasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        labelText: '确认密码',
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
                      if (_isRegister) {
                        Api.register(userName, password, repassword).then((resp) {
                          print(resp);
                          ToastUtil.show("注册成功,请登录");
                          setState(() {
                            _isRegister = false;
                            FocusScope.of(context).requestFocus(_userNameFocusNode);
                          });
                        }, onError: (e) {
                          print(e);
                        });
                      } else {
                        Api.login(userName, password).then((resp) {
                          print(resp);
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
          ),
        ),
    );
  }
}

class _SystemPadding extends StatelessWidget {

  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.padding,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}