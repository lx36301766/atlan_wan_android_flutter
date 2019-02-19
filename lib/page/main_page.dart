import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/page/main_page_list/classification_list.dart';
import 'package:atlan_wan_android_flutter/widget/drawer_widget.dart';
import 'package:atlan_wan_android_flutter/page/main_page_list/home_list.dart';
import 'package:atlan_wan_android_flutter/page/main_page_list/navigation_list.dart';
import 'package:atlan_wan_android_flutter/page/main_page_list/project_list.dart';
import 'package:atlan_wan_android_flutter/page/main_page_list/wechat_public_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: DrawerView(),
      ),
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Text(appName),
      centerTitle: true,
//      bottom: PreferredSize(
//          child: Container(
//            padding: EdgeInsets.all(5),
//            alignment: Alignment.center,
//            decoration: BoxDecoration(
//                color: Colors.blueAccent
//            ),
//            child: const Text('downstairs'),
//          ),
//          preferredSize: const Size.fromHeight(30.0)
//      ),
      actions: <Widget>[
//        IconButton(
//          icon: Icon(Icons.shopping_cart),
//          tooltip: 'Open shopping cart',
//          onPressed: () {
//            // ...
//          },
//        ),
        PopupMenuButton(
//          icon: Icon(
//            icon:
//          ),
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                PopupMenuItem<String>(child: const Text('Doge'), value: 'Doge'),
                PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
              ],
          onSelected: _onPopMenuSelected),
      ],
    );
  }

  void _onPopMenuSelected(String value) {

  }

  Widget buildBody() {
    return IndexedStack(
      index: _pageIndex,
      children: <Widget>[
        HomeListPage(),
        ClassificationListPage(),
        NavigationListPage(),
        ProjectListPage(),
        WechatPublicListPage(),
      ],
    );
  }

  Widget buildBottomNavigation() {
    return BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        fixedColor: appIconColor,
        onTap: (int index) {
          setState(() {
            this._pageIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud,
//                color: appIconColor,
            ),
            title: Text("体系"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            title: Text("导航"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text("项目"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: Text("公共号"),
          ),
        ]);
  }

}
