
import 'dart:async';

import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_banner_bean.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
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

  List<HomeBannerBean> _bannerListData;

  List<HomeListDataBean> _homeListData = [];

  HomeListBean _homeListBean;

  @override
  void initState() {
    super.initState();
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
    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => _buildItem(i),
      itemCount: _homeListData == null ? 0 : _homeListData.length + 2,
//      controller: _scrollController,
    );

    var _pullToRefreshWidget = NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      // RefreshIndicator / LiquidPullToRefresh
      child: LiquidPullToRefresh(
        scrollController: _scrollController,
        color: appIconColor,
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

  bool _onNotification(ScrollNotification scrollNotification) {
    return false;
  }

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

  void _requestBannerData() async {
    List<HomeBannerBean> data = await ApiRequester.getHomeBanner();
    print(data.toString());
    if (data != null && data.length > 0) {
      setState(() {
        _bannerListData = data;
      });
    }
//    ApiRequester.getHomeBanner().then((resp){
//      print(resp.toString());
//      if (resp != null && resp.length > 0) {
//        setState(() {
//          _bannerListData = resp;
//        });
//      }
//    }, onError: (e) {
//      print(e);
//    });
  }

  void _requestListData() async {
    HomeListBean bean = await ApiRequester.getHomeList(_listPageIndex);
    print(bean.toString());
    setState(() {
      _homeListBean = bean;
      _homeListData.addAll(bean.datas);
    });
//    ApiRequester.getHomeList(_listPageIndex).then((HomeListBean bean) {
//      print(bean.toString());
//      setState(() {
//        _homeListBean = bean;
//        _homeListData.addAll(bean.datas);
//      });
//    }, onError: (e) {
//      print(e);
//    });
  }

  Widget _buildItem(int index) {
    if (index == 0) {
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
                    placeholder: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(appIconColor),
                    ),
                    errorWidget: Icon(Icons.error),
                    imageUrl: _bannerListData[index].imagePath,
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else if (index == _homeListData.length + 1) {
      print("_homeListBean.pageCount=${_homeListBean?.pageCount}, _listPageIndex=$_listPageIndex");
      String loadMore = _homeListBean?.pageCount == _listPageIndex ? "我是有底线的": "加载中...";
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(loadMore),
        ),
      );
    } else {
      HomeListDataBean data = _homeListData[index - 1];
      data.title = htmlUnescape.convert(data.title);

      return Container(
//      color: Colors.blue,
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFFf0f8FF),
            highlightColor: appIconColor,
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
                      children: <Widget>[
                        Text("${data.author} / ${data.superChapterName}-${data.chapterName}",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 2.0,
                          ),
                        ),
                        Text(data.niceDate,
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
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

}
