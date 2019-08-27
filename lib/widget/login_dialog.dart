

import 'package:atlan_wan_android_flutter/util/constants.dart';
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

  bool _isRegister = false;

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: FlatButton(
                      child: Text("登录",
                        style: TextStyle(
                          color: _isRegister ? Colors.black : appMainColor
                        ),
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
                      child: Text("注册",
                        style: TextStyle(
                            color: _isRegister ? appMainColor : Colors.black
                        ),
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
                      prefixIcon: Icon(Icons.lock),
                      labelText: '请输入密码',
                    ),
                    obscureText: true,
                  ),
                  if (_isRegister) TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: Icon(Icons.lock),
                      labelText: '确认密码',
                    ),
                    obscureText: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
