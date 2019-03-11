
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

  var _homeListBeans = <int, HomeListBean> {};

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
          if (_tabController.indexIsChanging) {
            print("change selected tab index = ${_tabController.index}");
            setState(() {
              _selectedItemIndex = _tabController.index;
              _requestProjectListData();
            });
          }
        });
      });
      _requestProjectListData();
    }
  }

  void _requestProjectListData() async {
    HomeListBean dataBean = await ApiRequester.getProjectList(_listPageIndex, _projectData[_selectedItemIndex].id);
    print(dataBean);
    if (dataBean != null && dataBean.datas != null && dataBean.datas.length > 0) {
      setState(() {
        _homeListBeans[_selectedItemIndex] = dataBean;
      });
    }
  }

  HomeListBean getSelectedListBean() => _homeListBeans[_selectedItemIndex];

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = List.generate(_projectData.length, (int index) =>
        Tab(text: htmlUnescape.convert(_projectData[index].name)));
    return Scaffold(
      appBar: _tabController == null ? null : _buildPageSlider(tabs),
      body: _tabController == null ? EmptyHolder() : TabBarView(
        controller: _tabController,
        children: List.generate(tabs.length, (int index) => _buildContent(index)),
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

  Widget _buildContent(int pageIndex) {
    List<HomeListDataBean> data = _homeListBeans[pageIndex]?.datas;
    if (data == null) {
      return EmptyHolder();
    } else {
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) => _buildItem(i, data),
        itemCount: data.length + 1,
      );
    }
  }

  Widget _buildItem(int listIndex, List<HomeListDataBean> data) {
    if (listIndex == data.length) {
      return _buildLoadMore();
    } else {
      return _buildListItem();
    }
  }

  Widget _buildListItem() {
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
                imageUrl: "http://img0.bdstatic.com/static/searchresult/img/logo-2X_32a8193.png",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadMore() {
    print("_homeListBean.pageCount=${getSelectedListBean()?.pageCount}, _listPageIndex=$_listPageIndex");
    String loadMore = getSelectedListBean()?.pageCount == _listPageIndex ? "我是有底线的": "加载中...";
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(loadMore),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

}
