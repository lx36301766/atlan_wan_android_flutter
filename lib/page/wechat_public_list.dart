
import 'dart:async';
import 'dart:collection';

import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class WechatPublicListPage extends StatefulWidget {

  @override
  _WechatPublicListPageState createState() => _WechatPublicListPageState();

}

class _WechatPublicListPageState extends KeepAliveState<WechatPublicListPage>
    with TickerProviderStateMixin {

  TabController _tabController;

  var _wechatAuthorData = <KnowledgeSystemBean>[];

  int _selectedItemIndex = 0;

  var _listPageIndexes;

  bool _isLastPage = false;

  Map<int, Set<HomeListDataBean>> _homeListBeans = {};

  @override
  void initState() {
    super.initState();
    _requestWeChatAuthorListData();
  }

  Future<void> _requestWeChatAuthorListData() async {
    List<KnowledgeSystemBean> data = await ApiRequester.getWeChatAuthorList();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _wechatAuthorData = data;
        _listPageIndexes = List.generate(_wechatAuthorData.length,  (int index) => 0);
        _tabController = TabController(length: _wechatAuthorData.length, vsync: this)..addListener(() {
          if (_tabController.index.toDouble() == _tabController.animation.value) {
            print("change selected tab index = ${_tabController.index}");
            setState(() {
              _selectedItemIndex = _tabController.index;
              _requestWeChatArticleListData(_selectedItemIndex);
            });
          }
        });
      });
      _requestWeChatArticleListData(_selectedItemIndex);
    }
  }

  Future<bool> _requestWeChatArticleListData(int index) async {
    HomeListBean dataBean = await ApiRequester.getWeChatArticleList(_listPageIndexes[index], _wechatAuthorData[index].id);
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
    List<Tab> tabs = List.generate(_wechatAuthorData.length, (int index) =>
        Tab(text: htmlUnescape.convert(_wechatAuthorData[index].name)));
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
          onLoadMore: ()=> _requestWeChatArticleListData(_selectedItemIndex),
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
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5.0,
        child: InkWell(
          splashColor: Color(0xFFf0f8FF),
          highlightColor: appMainColor,
          onTap: () => Pages.openWebView(context, dataBean.title, dataBean.link),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(dataBean.niceDate, style: TextStyle(fontSize: 10, color: Colors.grey.shade600))
                )
              ],
            ),
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
