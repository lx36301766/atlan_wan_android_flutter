
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/article_item_widget.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SquareListModel extends ChangeNotifier {

  int _listPageIndex = 0;

  List<HomeListDataBean> _homeListData = [];

  HomeListBean _lastHomeListBean;

  Future<void> _requestListData() async {
    print("_requestListData");
    var homeListBean = await Api.getUserArticleList(_listPageIndex);
    if (homeListBean != null && homeListBean.datas.isNotEmpty) {
      _lastHomeListBean = homeListBean;
      _homeListData.addAll(_lastHomeListBean.datas);
    }
    if (homeListBean != null) {
      notifyListeners();
    }
  }

  Future<void> _requestNextPageData() async {
    print("_requestNextPageData");
    _listPageIndex++;
    _requestListData();
  }

  Future<void> _reloadAllData() async {
    print("_reloadAllData");
    _homeListData.clear();
    _listPageIndex = 0;
    _requestListData();
  }

}


class SquareListPage extends StatefulWidget {

  @override
  _SquareListPageState createState() => _SquareListPageState();

}

class _SquareListPageState extends KeepAliveState<SquareListPage> {

  ScrollController _scrollController;
  PageController _pageController;

  SquareListModel _model;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _model = SquareListModel().._requestListData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SinglePageProviderConsumer<SquareListModel>(
        model: _model,
        builder: (context, model, child) {
          _scrollController ??= ScrollController()..addListener(() {
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              debugPrint("到底啦！！！");
              model._requestNextPageData();
            }
          });

          return model._homeListData.isEmpty ? EmptyHolder() : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) => false,
            // RefreshIndicator / LiquidPullToRefresh
            child: LiquidPullToRefresh(
              scrollController: _scrollController,
              color: appMainColor,
              onRefresh: () {
//                _pageController.jumpToPage(0);
                return model._reloadAllData();
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) => _buildItem(i, model),
                itemCount: model._homeListData == null ? 0 : model._homeListData.length + 1,
              ),
            ),
          );
        }
    );
  }

  Widget _buildItem(int index, SquareListModel data) {
    if (index == data._homeListData.length) {
      return _buildLoadMore(data._lastHomeListBean, data._listPageIndex);
    } else {
      return ArticleItemWidget(data._homeListData[index], index,
        displayTab: false,
      );
    }
  }

  Widget _buildLoadMore(HomeListBean _homeListBean, int _listPageIndex) {
    print("_homeListBean.pageCount=${_homeListBean?.pageCount}, _listPageIndex=$_listPageIndex");
    String loadMore = _homeListBean?.pageCount == _listPageIndex ? "我是有底线的": "加载中...";
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(loadMore),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

}
