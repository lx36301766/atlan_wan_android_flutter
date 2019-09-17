
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeListPage extends StatefulWidget {

  @override
  _HomeListPageState createState() => _HomeListPageState();

}

class _HomeListPageState extends KeepAliveState<HomeListPage> {

  ScrollController _scrollController;

  PageController _pageController;

  int _listPageIndex = 0;

  int _articleTopSize = 0;

  List<HomeBannerBean> _bannerListData;

  List<HomeListDataBean> _homeListData = [];

  HomeListBean _homeListBean;

  @override
  void initState() {
    super.initState();

    void _scrollListener() {
      //滑到最底部刷新
//    print("pixels=${_scrollController.position.pixels} , maxScrollExtent=${_scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("到底啦！！！");
//      // 模拟滑到底了
//      if (_listPageIndex < 3) {
//        _listPageIndex++;
//      } else {
//        _listPageIndex = _homeListBean.pageCount;
//      }
        _listPageIndex++;
        _requestListData();
      }
    }

    _scrollController = ScrollController()..addListener(_scrollListener);
    _pageController = PageController(initialPage: 0);
    _requestBannerData();
    _requestListData();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_bannerListData == null && _homeListData.isEmpty) {
      return EmptyHolder();
    }

    Widget _buildItem(int index) {
      if (index == 0) {
        return _buildBanner(index);
      } else if (index == _homeListData.length + 1) {
        return _buildLoadMore();
      } else {
        return _buildHomeListItem(index);
      }
    }

    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => _buildItem(i),
      itemCount: _homeListData == null ? 0 : _homeListData.length + 2,
//      controller: _scrollController,
    );

    var _pullToRefreshWidget = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) => false,
      // RefreshIndicator / LiquidPullToRefresh
      child: LiquidPullToRefresh(
        scrollController: _scrollController,
        color: appMainColor,
        onRefresh: _pullToRefresh,
        child: list,
      ),
    );
    return _pullToRefreshWidget;
  }

  Future<Null> _pullToRefresh() async {

    _pageController.jumpToPage(0);
    _requestBannerData();

    _homeListData.clear();
    _listPageIndex = 0;
    _requestListData();
    return null;
  }

  Future<void> _requestBannerData() async {
    List<HomeBannerBean> data = await Api.getHomeBanner();
    print(data.toString());
    if (data != null && data.length > 0 && mounted) {
      setState(() {
        _bannerListData = data;
      });
    }
  }

  Future<void> _requestListData() async {
    List<HomeListDataBean> articleTopData;
    if (_listPageIndex == 0) {
      articleTopData = await Api.getArticleTop();
      _articleTopSize = articleTopData.length;
    }
    HomeListBean bean = await Api.getHomeList(_listPageIndex);
    print(bean.toString());
    if (mounted) {
      setState(() {
        _homeListBean = bean;
        if (articleTopData != null && articleTopData.isNotEmpty) {
          _homeListData.addAll(articleTopData);
        }
        _homeListData.addAll(bean.datas);
      });
    }
  }

  Widget _buildBanner(int index) {
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

  Widget _buildLoadMore() {
    print("_homeListBean.pageCount=${_homeListBean?.pageCount}, _listPageIndex=$_listPageIndex");
    String loadMore = _homeListBean?.pageCount == _listPageIndex ? "我是有底线的": "加载中...";
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(loadMore),
      ),
    );
  }

  Widget _buildHomeListItem(int index) {
    HomeListDataBean data = _homeListData[index - 1];
    data.title = htmlUnescape.convert(data.title);
    return Container(
//      color: Colors.blue,
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        child: InkWell(
          splashColor: Color(0xFF30f86F),
          highlightColor: appMainColor,
          onTap: () {
            var data = _homeListData[index - 1];
            Pages.openWebView(context, data.title, data.link);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:5, horizontal:12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(data.title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 5.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 10,
                        child: Row(
                          children: <Widget>[
                            Visibility(
                              visible: index <= _articleTopSize,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset('image/top.png',
                                  fit: BoxFit.none,
                                  width: 15,
                                  height: 15,
                                  scale: 7.0,
                                ),
                              ),
                            ),
                            Text
                              ("${data.author} • ${data.superChapterName} • ${data.chapterName}",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                                wordSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(data.niceDate,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
