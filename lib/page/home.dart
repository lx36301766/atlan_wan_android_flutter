import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(Constants.APP_NAME),
        centerTitle: true,
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent
              ),
              child: const Text('Atlan'),
            ),
            preferredSize: const Size.fromHeight(30.0)
        ),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (BuildContext context) =>
              <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                    child: const Text('Doge'), value: 'Doge'),
                PopupMenuItem<String>(
                    child: const Text('Lion'), value: 'Lion'),
              ],
              onSelected: _onPopMenuSelected
          ),
//          new Text("123"),
//          new Text("45g7"),
        ],
      ),
    );
  }

  void _onPopMenuSelected(String value) {

  }

}
