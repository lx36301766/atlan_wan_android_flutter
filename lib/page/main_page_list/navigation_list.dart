
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:flutter/material.dart';

class NavigationListPage extends StatefulWidget {

  @override
  _NavigationListPageState createState() => _NavigationListPageState();

}

class _NavigationListPageState extends KeepAliveState<NavigationListPage> {

  ScrollController _scrollController = new ScrollController();

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
    return null;
  }

  Widget buildItem(int i) {
    return Text("i=$i");
  }

}
