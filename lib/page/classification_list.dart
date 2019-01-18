
import 'package:flutter/material.dart';

class ClassificationListPage extends StatefulWidget {

  @override
  _ClassificationListPageState createState() => _ClassificationListPageState();

}

class _ClassificationListPageState extends State<ClassificationListPage> {

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
