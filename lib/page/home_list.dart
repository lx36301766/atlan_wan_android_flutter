
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/home_list_bean.dart';
import 'package:flutter/material.dart';

class HomeListPage extends StatefulWidget {

  @override
  _HomeListPageState createState() => _HomeListPageState();

}

class _HomeListPageState extends State<HomeListPage> {

  ScrollController _scrollController = new ScrollController();

  int _listPageIndex = 0;

  @override
  void initState() {
    super.initState();
//    ApiRequester.getHomeList(_listPageIndex).then((HomeListBean bean) {
//
//    } , onError: (error) {
//
//    });

  }

  void requestPageData() {
  }

  @override
  Widget build(BuildContext context) {

    Widget list = ListView.builder(
      itemBuilder: (context, i) => buildItem(i),
      itemCount: 50,
      controller: _scrollController,
    );


    return RefreshIndicator(
      child: list,
      onRefresh: _pullToRefresh,
    );
  }

  Future<void> _pullToRefresh() {
    ApiRequester.getHomeList(_listPageIndex).then((HomeListBean bean) {

    }).catchError((error) {

    });
    return null;
  }

  Widget buildItem(int i) {
    return Text("i=$i");
  }

}
