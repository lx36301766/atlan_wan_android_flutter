
import 'dart:async';

import 'package:atlan_wan_android_flutter/constants.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_banner_bean.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
import 'package:flutter/material.dart';

class HomeListPage extends StatefulWidget {

  @override
  _HomeListPageState createState() => _HomeListPageState();

}

class _HomeListPageState extends State<HomeListPage> {

  ScrollController _scrollController = new ScrollController();

  PageController _pageController = new PageController(initialPage: 0);

  int _listPageIndex = 0;

  List<HomeBannerBean> _bannerListData;

  HomeListBean _homeListBean;

  @override
  void initState() {
    super.initState();
    _requestBannerData();
    _requestListData();
  }

  @override
  Widget build(BuildContext context) {
    Widget list = ListView.builder(
      itemBuilder: (context, i) => _buildItem(i),
      itemCount: (_homeListBean == null || _homeListBean.datas == null) ? 0 : _homeListBean.datas.length,
      controller: _scrollController,
    );
    return RefreshIndicator(
      child: list,
      onRefresh: _pullToRefresh,
    );
  }

  Future<void> _pullToRefresh() {
    _requestBannerData();
    _listPageIndex = 0;
    _requestListData();
    return null;
  }

  void _requestBannerData() {
    ApiRequester.getHomeBanner().then((resp){
      print(resp.toString());
      if (resp != null && resp.length > 0) {
        setState(() {
          _bannerListData = resp;
        });
      }
    }, onError: (e) {
      print(e);
    });
  }

  void _requestListData() {
    ApiRequester.getHomeList(_listPageIndex).then((HomeListBean bean) {
      print(bean.toString());
      setState(() {
        _homeListBean = bean;
      });
    }, onError: (e) {
      print(e);
    });
  }

  Widget _buildItem(int index) {
    if (index == 0) {
      return AspectRatio(
        aspectRatio: 9 / 5,
        child: Card(
          child: GestureDetector(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _bannerListData == null ? 0 : _bannerListData.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: CachedNetworkImage(
                    placeholder: new CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(appIconColor),
                    ),
                    errorWidget: new Icon(Icons.error),
                    imageUrl: _bannerListData[index].imagePath,
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      HomeListDataBean data = _homeListBean.datas[index];
      return Container(
//      color: Colors.blue,
        padding: EdgeInsets.fromLTRB(10, 10, 2, 3),
        child: OutlineButton(
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Text(data.title),
              Text("${data.superChapterName} / ${data.chapterName}"),
              Text(data.niceDate),
            ],
          ),
        )
      );
//      return Text("");
    }
  }

}
