import 'package:atlan_wan_android_flutter/page/home_list.dart';
import 'package:atlan_wan_android_flutter/page/knowledge_system_list.dart';
import 'package:atlan_wan_android_flutter/page/navigation_list.dart';
import 'package:atlan_wan_android_flutter/page/project_list.dart';
import 'package:atlan_wan_android_flutter/page/wechat_public_list.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/widget/drawer_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _pageIndex = 0;

  PageController _pageController;

  String _titleName = appName;

  List<BottomItemInfo> _buttonItemList = [
    BottomItemInfo("首页", Icons.home, HomeListPage()),
    BottomItemInfo("体系", Icons.cloud, KnowledgeSystemListPage()),
    BottomItemInfo("导航", Icons.navigation, NavigationListPage()),
    BottomItemInfo("项目", Icons.folder, ProjectListPage()),
    BottomItemInfo("公共号", Icons.public, WechatPublicListPage()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(child: DrawerView()),
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: appMainColor,
      title: Text(_titleName),
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
        PopupMenuButton(
//          icon: Icon(
//            icon:
//          ),
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: const Text('Doge'), value: 'Doge'),
                  PopupMenuItem<String>(
                      child: const Text('Lion'), value: 'Lion'),
                ],
            onSelected: _onPopMenuSelected),
      ],
    );
  }

  void _onPopMenuSelected(String value) {}

  Widget buildBody() {
//    return IndexedStack(
//      index: _pageIndex,
//      children: <Widget>[
//        HomeListPage(),
//        KnowledgeSystemListPage(),
//        NavigationListPage(),
//        ProjectListPage(),
//        WechatPublicListPage(),
//      ],
//    );
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: _buttonItemList.map((item) => item.widget).toList(),
      onPageChanged: (int page) {
        setState(() {
          this._pageIndex = page;
          _titleName = _buttonItemList[_pageIndex].name;
        });
      },
      controller: _pageController,
    );
  }

  Widget buildBottomNavigation() {
    return BottomNavigationBar(
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        fixedColor: appMainColor,
        onTap: (int index) {
//          setState(() {
//            this._pageIndex = index;
//          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: _buttonItemList.map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon),
            title: Text(item.name),
        )).toList()
    );
  }
}

class BottomItemInfo {

  String name;
  IconData icon;
  Widget widget;

  BottomItemInfo(this.name, this.icon, this.widget);

}
