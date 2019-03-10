
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/project_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends KeepAliveState<ProjectListPage> with TickerProviderStateMixin {

  TabController _tabController;

  var _projectData = <ProjectBean>[];

  int _selectedItemIndex = 0;

  int _listPageIndex = 0;

  HomeListBean _homeListBean; 

  @override
  void initState() {
    super.initState();
    _requestProjectData();
  }

  void _requestProjectData() async {
    List<ProjectBean> data = await ApiRequester.getProject();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _projectData = data;
        _tabController = TabController(length: _projectData.length, vsync: this)..addListener(() {
          print("change selected tab index = ${_tabController.index}");
          setState(() {
            _selectedItemIndex = _tabController.index;
            _requestProjectListData();
          });
        });
      });
      _requestProjectListData();
    }
  }

  void _requestProjectListData() async {
    HomeListBean data = await ApiRequester.getProjectList(_listPageIndex, _projectData[_selectedItemIndex].id);
    print(data);
    if (_homeListBean != null && _homeListBean.datas != null && _homeListBean.datas.length > 0) {
//      setState(() {
//        _homeListBean = data;
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = List.generate(_projectData.length, (int index) => Tab(text: _projectData[index].name));
    return Scaffold(
      appBar: _tabController == null ? null : _buildPageSlider(tabs),
      body: _tabController == null ? EmptyHolder() : TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) => _buildListItem(tab)).toList(),
      ),
    );
  }

  Widget _buildPageSlider(List<Tab> tabs) {
    return PreferredSize(
      preferredSize: Size.fromHeight(35.0),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.black38,
          indicatorWeight: 1.0,
          indicatorColor: appIconColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: appIconColor,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }

  Widget _buildListItem(Tab tab) {
//    HomeListDataBean data = _homeListBean.datas[tab.];
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5.0,
        child: InkWell(
          splashColor: Color(0xFFf0f8FF),
          highlightColor: appIconColor,
          onTap: () {

          },
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                placeholder: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(appIconColor),
                ),
                errorWidget: Icon(Icons.error),
                imageUrl: "http://www.wanandroid.com/blogimgs/92f34dfb-a3ae-44fe-ad1a-d1ff22c773e5.png",
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

}
