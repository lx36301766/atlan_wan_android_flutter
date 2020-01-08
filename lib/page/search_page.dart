import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
//      focusNode: _passwordFocusNode,
//      controller: _passwordController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 15),
            prefixIcon: Icon(FontAwesomeIcons.heart),
            hintText: '请输入密码',
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
