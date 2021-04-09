
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0))),
        backgroundColor: appMainColor,
        title: Text("关于"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Image.asset(
                'image/logo.png',
                scale: 1.5,
                fit: BoxFit.none,
              ),
            ),
            Flexible(
              flex: 1,
              child: Text("版本号：1.0.0",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontStyle: FontStyle.normal
                  ),
              ),
            ),
          ],
        ),
      )
    );
  }

}
