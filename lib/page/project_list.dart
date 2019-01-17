
import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {

  @override
  _ProjectListPageState createState() => _ProjectListPageState();

}

class _ProjectListPageState extends State<ProjectListPage> {

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
