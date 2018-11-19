
import 'package:flutter/material.dart';

class DrawerView extends StatefulWidget {

  @override
  _DrawerViewState createState() => _DrawerViewState();

}

class _DrawerViewState extends State<DrawerView> {

  @override
  Widget build(BuildContext context) {
    Widget avatarArea = Column(
      children: <Widget>[
        CircleAvatar(
          child: Icon(Icons.person_pin_circle),
          backgroundColor: Colors.pink,
        ),
        FlatButton(
          child: Text('username'),
          onPressed: null,
        ),
      ],
    );

    ListView userInfoList = ListView(

    );

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          avatarArea,
          userInfoList
        ],
      ),
    );
  }

}
