
import 'package:flutter/material.dart';

class HomeListPage extends StatefulWidget {

  @override
  _HomeListPageState createState() => _HomeListPageState();

}

class _HomeListPageState extends State<HomeListPage> {

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
