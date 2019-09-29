import 'package:atlan_wan_android_flutter/bloc/bloc_provider.dart';
import 'package:atlan_wan_android_flutter/bloc/login_bloc.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
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

  List<_BottomItemInfo> _buttonItemList = [
    _BottomItemInfo("首页", Icons.home, HomeListPage()),
    _BottomItemInfo("体系", Icons.cloud, KnowledgeSystemListPage()),
    _BottomItemInfo("导航", Icons.navigation, NavigationListPage()),
    _BottomItemInfo("项目", Icons.folder, ProjectListPage()),
    _BottomItemInfo("公共号", Icons.receipt, WechatPublicListPage()),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._pageIndex);
    BlocProvider.of<LoginBloc>(context).getUserPoint();
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
        backgroundColor: appMainColor,
        title: Text(_buttonItemList[_pageIndex].name),
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
              itemBuilder: (BuildContext context) =>
                  testApi.keys.map((key) {
                    return PopupMenuItem(
                      child: Text(key),
                      value: key,
                    );
                  }).toList(),
              onSelected: (value) {
                print("_onPopMenuSelected, value=$value");
                if (testApi[value] != null) {
                  testApi[value]().then((resp) {
                    print(resp);
                  }, onError: (e) {
                    print(e);
                  });
                }
              }
          ),
        ],
    );
  }

  Map<String, Function> testApi = {
    "register": () => Api.register("12r43654656563", "455123123", "455123123"),
    "login": () => Api.login("lx364301766", "5393147"),
    "logout": () => Api.logout(),
    "getCollect": () => Api.getCollectList(0),
    "addCollectInside": () => Api.addCollectInside(8920),
    "deleteCollect": () => Api.deleteCollect(0),
    "deleteCollect2": () => Api.deleteCollect2(0),
    "getCollectWebsite": () => Api.getCollectWebsite(),
    "addCollectWebsite": () => Api.addCollectWebsite("", ""),
    "updateCollectWebsite": () => Api.updateCollectWebsite(0, "", ""),
    "deleteCollectWebsite": () => Api.deleteCollectWebsite(0),

    "getPointLeaderboardList": () => Api.getUserPointRankList(1),
    "getUserPoint": () => Api.getUserPoint(),
    "getUserPointGetList": () => Api.getUserEarnPointsList(1),
  };

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

class _BottomItemInfo {

  String name;
  IconData icon;
  Widget widget;

  _BottomItemInfo(this.name, this.icon, this.widget);

}
