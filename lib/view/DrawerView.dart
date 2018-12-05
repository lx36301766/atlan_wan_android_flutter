import 'package:flutter/material.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {

    Widget header4 = Expanded(
      child: DrawerHeader(
        margin: EdgeInsets.only(top: 10),
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 1000),
        child: FlatButton(
          onPressed: () {},
          splashColor: Color(0x00FFFFFF),
//        highlightColor: Color(0x00FFFFFF),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  child: Icon(Icons.person_pin_circle),
                  backgroundColor: Colors.pink,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('username'),
              ),
            ],
          ),
        ),
      ),
    );

    ListView list = ListView(

      children: <Widget>[
//        RadioListTile<String>(
//          groupValue: "group",
//          value: "value",
//          title: Text("lx"),
//          activeColor: Colors.tealAccent,
//          onChanged: (String str) {},
//        ),
//        SwitchListTile(
//          value: true,
//          onChanged: (bool select){},
//
//        ),
//        CheckboxListTile(
//          value: true,
//          onChanged: (bool checked){},
//        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.android),
          title: Text("android"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.mood),
          title: Text("mood"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.cloud),
          title: Text("cloud"),
          onTap: () {},
        ),
        Divider(),
        AboutListTile(
          icon: Icon(Icons.info),
//          child: ,
        ),
      ],
    );

    return Container(
//      color: Colors.blue,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          header4,
          Expanded(
            child: list,
          )
        ],
      ),
    );
  }
}
