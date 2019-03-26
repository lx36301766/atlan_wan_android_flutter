
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class ProjectListPage extends StatefulWidget {

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends KeepAliveState<ProjectListPage> with TickerProviderStateMixin {

  TabController _tabController;

  var _projectData = <KnowledgeSystemBean>[];

  int _selectedItemIndex = 0;

  int _listPageIndex = 0;

  var _homeListBeans = <int, HomeListBean> {};

  @override
  void initState() {
    super.initState();
    _requestProjectData();
  }

  Future<void> _requestProjectData() async {
    List<KnowledgeSystemBean> data = await ApiRequester.getProject();
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

  Future<bool> _requestProjectListData() async {
    HomeListBean dataBean = await ApiRequester.getProjectList(_listPageIndex, _projectData[_selectedItemIndex].id);
    print(dataBean);
    if (dataBean != null && dataBean.datas != null && dataBean.datas.length > 0) {
      setState(() {
        _listPageIndex++;
        _homeListBeans[_selectedItemIndex] = dataBean;
      });
      return true;
    }
    return false;
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
      return LoadMore(
        onLoadMore: _requestProjectListData,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, i) => _buildListItem(i, data),
          itemCount: data.length + 1,
        ),
      );
    }
  }

  Widget _buildListItem(int listIndex, List<HomeListDataBean> data) {
    // if (listIndex == data.length) {
    //   return _buildLoadMore();
    // } else {
    //   return _buildCardItem(data[listIndex]);
    // }
    return _buildCardItem(data[listIndex]);
  }

  Widget _buildCardItem(HomeListDataBean dataBean) {
    var title = htmlUnescape.convert(dataBean.title);
    var desc = htmlUnescape.convert(dataBean.desc);
    var name = "${dataBean.author}-${dataBean.chapterName}";
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFFf0f8FF),
            highlightColor: appIconColor,
            onTap: () => Pages.openWebView(context, dataBean.title, dataBean.link),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title, 
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(desc, 
                              style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(name, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                              Text(dataBean.niceDate, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      placeholder: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(appIconColor),
                      ),
                      errorWidget: Icon(Icons.error),
                      imageUrl: dataBean.envelopePic,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
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
