
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

class HomeListModel extends ChangeNotifier {

  int _listPageIndex = 0;

  int _articleTopSize = 0;

  List<HomeBannerBean> _bannerListData;

  List<HomeListDataBean> _homeListData = [];

  HomeListBean _lastHomeListBean;

  void _requestBannerData() async {
    List<HomeBannerBean> data = await Api.getHomeBanner();
    print(data.toString());
    if (data != null && data.length > 0) {
        _bannerListData = data;
        notifyListeners();
    }
  }

  void _requestListData() async {
    List<Future> tasks = List();
    if (_listPageIndex == 0) {
      tasks.add(Api.getArticleTop());
    }
    tasks.add(Api.getHomeList(_listPageIndex));
    dynamic result = await Future.wait(tasks);
    List<HomeListDataBean> articleTopData;
    HomeListBean homeListBean;
    if (result.length == 2) {
      articleTopData = result[0];
      homeListBean = result[1];
    } else if (result.length == 1) {
      homeListBean = result[0];
    } else {
      return;
    }
    if (articleTopData != null && articleTopData.isNotEmpty) {
      _articleTopSize = articleTopData.length;
      _homeListData.addAll(articleTopData);
    }
    if (homeListBean != null && homeListBean.datas.isNotEmpty) {
      _lastHomeListBean = homeListBean;
      _homeListData.addAll(_lastHomeListBean.datas);
    }
    if (articleTopData != null || homeListBean != null) {
      notifyListeners();
    }
  }

  void _requestNextPageData() {
    _listPageIndex++;
    _requestListData();
  }

  void _reloadAllData() {
    _homeListData.clear();
    _listPageIndex = 0;
    _requestBannerData();
    _requestListData();
  }

}



class HomeListPage extends StatefulWidget {

  @override
  _HomeListPageState createState() => _HomeListPageState();

}

class _HomeListPageState extends KeepAliveState<HomeListPage> {

  ScrollController _scrollController;
  PageController _pageController;

  HomeListModel _model;

  @override
  void initState() {
    super.initState();

    _model = HomeListModel()
      .._requestBannerData()
      .._requestListData();

    _scrollController = ScrollController()
      ..addListener(() {
        //滑到最底部刷新
//    print("pixels=${_scrollController.position.pixels} , maxScrollExtent=${_scrollController.position.maxScrollExtent}");
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          debugPrint("到底啦！！！");
//      // 模拟滑到底了
//      if (_listPageIndex < 3) {
//        _listPageIndex++;
//      } else {
//        _listPageIndex = _homeListBean.pageCount;
//      }
          _model._requestNextPageData();
        }
      });
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SinglePageProviderConsumer<HomeListModel>(
        model: _model,
        builder: (context, model, child) {
          return model._bannerListData == null && model._homeListData.isEmpty ? EmptyHolder() : NotificationListener<
              ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) => false,
            // RefreshIndicator / LiquidPullToRefresh
            child: LiquidPullToRefresh(
              scrollController: _scrollController,
              color: appMainColor,
              onRefresh: () {
                _pageController.jumpToPage(0);
                model._reloadAllData();
                return null;
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) => _buildItem(i, model),
                itemCount: model._homeListData == null ? 0 : model._homeListData.length + 2,
              ),
            ),
          );
        }
    );
  }

  Widget _buildItem(int index, HomeListModel data) {
    if (index == 0) {
      return _buildBanner(index, data._bannerListData);
    } else if (index == data._homeListData.length + 1) {
      return _buildLoadMore(data._lastHomeListBean, data._listPageIndex);
    } else {
      return ArticleItemWidget(data._homeListData[index - 1], index, data._articleTopSize);
    }
  }

  Widget _buildBanner(int index, List<HomeBannerBean> _bannerListData) {
    return AspectRatio(
      aspectRatio: 9 / 5,
      child: Card(
        elevation: 5.0,
        shape: Border(),
        margin: EdgeInsets.all(0.0),
        child: GestureDetector(
          onTap: () {
            var data = _bannerListData[index];
            Pages.openWebView(context, data.title, data.url);
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount: _bannerListData == null ? 0 : _bannerListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appMainColor),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: _bannerListData[index].imagePath,
                ),
              );
            },
          ),
        ),
      ),
    );
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
