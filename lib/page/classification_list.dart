

import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClassificationListPage extends StatefulWidget {

  final KnowledgeSystemBean rootBean;

  ClassificationListPage(this.rootBean);

  @override
  _ClassificationListState createState() => _ClassificationListState();

}

class _ClassificationListState extends State<ClassificationListPage> {

  List<HomeListDataBean> _classificationListData = [];

  int _listPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestKnowledgeSystemData(_listPageIndex);
  }

  Future<void> _requestKnowledgeSystemData(int page) async {
    var data = await ApiRequester.getKnowledgeSystemChildren(page, widget.rootBean.id);
    print(data);
    if (data != null && data.datas.isNotEmpty) {
      setState(() {
        _classificationListData.addAll(data.datas);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appMainColor,
          title: Text(''),
          centerTitle: true,
        ),
        body: _buildBody(),
    );
  }

  Widget _buildBody() {
    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => _buildItem(i),
      itemCount: _classificationListData == null ? 0 : _classificationListData.length,
//      controller: _scrollController,
    );

    var _pullToRefreshWidget = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) => false,
      // RefreshIndicator / LiquidPullToRefresh
      child: LiquidPullToRefresh(
//        scrollController: _scrollController,
        color: appMainColor,
        onRefresh: _pullToRefresh,
        child: list,
      ),
    );
    return _pullToRefreshWidget;
  }

  Future<Null> _pullToRefresh() async {

    return null;
  }

  _buildItem(int i) {
    return Container(

    );
  }

}
