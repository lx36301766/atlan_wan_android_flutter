
import 'package:flutter/material.dart';

class NavigationListPage extends StatefulWidget {

  @override
  _NavigationListPageState createState() => _NavigationListPageState();

}

class _NavigationListPageState extends State<NavigationListPage> {

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
