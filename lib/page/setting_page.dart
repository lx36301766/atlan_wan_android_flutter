import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

// flutter-redux

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Tuple2<String, Function>> settingItems = [
    Tuple2("字体", () => {ToastUtil.show("ziti")})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0))),
          backgroundColor: appMainColor,
          title: Text("设置"),
          centerTitle: true,
        ),
        body: ListView.builder(
//          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, i) => _buildSettingItems(i),
          itemCount: settingItems.length,
        ));
  }

  Widget _buildSettingItems(int index) {
    var item = settingItems[index];

    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFFf0f8FF),
            highlightColor: appMainColor,
            onTap: () => {
              item.item2()
            },
            child: Text(item.item1),
          )),
    );
  }
}
