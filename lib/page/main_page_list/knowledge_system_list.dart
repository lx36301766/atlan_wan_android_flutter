
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/widget/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class KnowledgeSystemListPage extends StatefulWidget {

  @override
  _KnowledgeSystemListPageState createState() => _KnowledgeSystemListPageState();

}

class _KnowledgeSystemListPageState extends KeepAliveState<KnowledgeSystemListPage> {

  ScrollController _scrollController = ScrollController();

//  AnimationController _animationController;
//  Animation<double> _iconTurns;
//  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
//  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  var _knowledgeSystemData = <KnowledgeSystemBean>[];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
//    _animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
//    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _requestKnowledgeSystemData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
//    _animationController?.dispose();
  }

  void _requestKnowledgeSystemData() async {
    List<KnowledgeSystemBean> data = await ApiRequester.getKnowledgeSystem();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _knowledgeSystemData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget list = ListView.builder(
      itemBuilder: (context, i) => _buildItem(_knowledgeSystemData[i]),
      itemCount: _knowledgeSystemData.length,
//      controller: _scrollController,
    );

    var _pullToRefreshWidget = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) => false,
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

  Future<void> _pullToRefresh() async {
    _requestKnowledgeSystemData();
    return null;
  }

  Widget _buildItem(KnowledgeSystemBean data) {
    var titles = <ListTile>[];
    data.children.forEach((child) =>
        titles.add(
            ListTile(
              title: Container(
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: appIconColor),
                      bottom: BorderSide(color: appIconColor),
                    )
                ),
                constraints: BoxConstraints.expand(width: 33, height: 44),
                child: Center(
                  child: Text(child.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontStyle: FontStyle.normal,
                      wordSpacing: 5.0,
                    ),),
                ),
              ),
            )));
    return Column(
      children: <Widget>[
        CustomExpansionTile(
          leading: Icon(Icons.reorder, color: appIconColor),
          title: Text(data.name,
            style: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              wordSpacing: 5.0,
            ),
          ),
          children: titles
        ),
//        Divider(
//          color: appIconColor,
//          height: 3,
//        )
      ],
    );
  }

}
