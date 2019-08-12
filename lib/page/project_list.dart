
import 'dart:async';
import 'dart:collection';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
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

  var _listPageIndexes;

  bool _isLastPage = false;

  Map<int, Set<HomeListDataBean>> _homeListBeans = {};

  @override
  void initState() {
    super.initState();
    _requestProjectData();
  }

  Future<void> _requestProjectData() async {
    List<KnowledgeSystemBean> data = await Api.getProject();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _projectData = data;
        _listPageIndexes = List.generate(_projectData.length,  (int index) => 1);
        _tabController = TabController(length: _projectData.length, vsync: this)..addListener(() {
          if (_tabController.index.toDouble() == _tabController.animation.value) {
            print("change selected tab index = ${_tabController.index}");
            setState(() {
              _selectedItemIndex = _tabController.index;
              _requestProjectListData(_selectedItemIndex);
            });
          }
        });
      });
      _requestProjectListData(_selectedItemIndex);
    }
  }

  Future<bool> _requestProjectListData(int index) async {
    HomeListBean dataBean = await Api.getProjectList(_listPageIndexes[index], _projectData[index].id);
    print(dataBean);
    if (dataBean == null) {
      return false;
    }
    setState(() {
      _isLastPage = dataBean.pageCount < 2 || dataBean.over;
      print("_isLastPage=$_isLastPage");
      if (_homeListBeans[index] == null) {
        _homeListBeans[index] = LinkedHashSet<HomeListDataBean>();
      }
      if (dataBean.datas != null && dataBean.datas.length > 0) {
        _listPageIndexes[index]++;
        _homeListBeans[index].addAll(dataBean.datas);
      }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Tab> tabs = List.generate(_projectData.length, (int index) =>
        Tab(text: htmlUnescape.convert(_projectData[index].name)));
    return Scaffold(
      appBar: _tabController == null ? null : _buildPageSlider(tabs),
      body: _tabController == null ? EmptyHolder() : TabBarView(
        controller: _tabController,
        children: List.generate(tabs.length, (int index) => _buildContent(_homeListBeans[index])),
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
          indicatorColor: appMainColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: appMainColor,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }

  Widget _buildContent(Set<HomeListDataBean> dataSet) {
    if (dataSet == null) {
      return EmptyHolder();
    } else {
      List<HomeListDataBean> data = List.from(dataSet);
      return KeepAliveStateContainer(
        child: LoadMore(
          isFinish: _isLastPage,
          onLoadMore: ()=> _requestProjectListData(_selectedItemIndex),
          textBuilder: (status) {
            if (status == LoadMoreStatus.nomore && data.isEmpty) {
              return "暂无数据";
            }
            return DefaultLoadMoreTextBuilder.chinese(status);
          },
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) => _buildCardItem(data[i]),
            itemCount: data.length,
          ),
        ),
      );
    }
  }

  Widget _buildCardItem(HomeListDataBean dataBean) {
    var title = htmlUnescape.convert(dataBean.title);
    var desc = htmlUnescape.convert(dataBean.desc);
    var name = "${dataBean.author}-${dataBean.chapterName}";
    return AspectRatio(
      key: PageStorageKey(dataBean),
      aspectRatio: 5 / 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFFf0f8FF),
            highlightColor: appMainColor,
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
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(appMainColor),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
  
//  Widget _buildLoadMore() {
//    print("_homeListBean.pageCount=${getSelectedListBean()?.pageCount}, _listPageIndex=$_listPageIndex");
//    String loadMore = getSelectedListBean()?.pageCount == _listPageIndex ? "我是有底线的": "加载中...";
//    return Center(
//      child: Padding(
//        padding: EdgeInsets.symmetric(vertical: 20),
//        child: Text(loadMore),
//      ),
//    );
//  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

}
