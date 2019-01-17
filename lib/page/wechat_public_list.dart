
import 'package:flutter/material.dart';

class WechatPublicListPage extends StatefulWidget {

  @override
  _WechatPublicListPageState createState() => _WechatPublicListPageState();

}

class _WechatPublicListPageState extends State<WechatPublicListPage> {

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    Widget list = ListView.builder(
      itemBuilder: null,
      itemCount: 5,
      controller: _scrollController,
    );


    return RefreshIndicator(
      child: list,
      onRefresh: _pullToRefresh,
    );
  }

  void _pullToRefresh() {

  }

}
