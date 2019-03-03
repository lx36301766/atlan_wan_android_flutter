
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/navigation_bean.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:flutter/material.dart';

class NavigationListPage extends StatefulWidget {

  @override
  _NavigationListPageState createState() => _NavigationListPageState();

}

class _NavigationListPageState extends KeepAliveState<NavigationListPage> {

  ScrollController _scrollController;

  var _navigationData = <NavigationBean>[];

  int _selectItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _requestKnowledgeSystemData();
  }

  void _requestKnowledgeSystemData() async {
    List<NavigationBean> data = await ApiRequester.getNavigation();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _scrollController.jumpTo(0);
        _navigationData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget list1 = ListView.builder(
      itemBuilder: (context, i) => _buildNavigation(i),
      itemCount: _navigationData?.length,
    );

    Widget list2 = ListView.builder(
      itemBuilder: (context, i) => _buildNavigationItem(i),
      itemCount: _navigationData.length > _selectItemIndex ?
              _navigationData[_selectItemIndex].articles.length : 0,
      controller: _scrollController,
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: list1,
          flex: 1,
        ),
        Expanded(
          child: list2,
          flex: 2,
        ),
      ],
    );
  }

  Widget _buildNavigation(int index) {
    return FlatButton(
      onPressed: () {
        _selectItemIndex = index;
        _requestKnowledgeSystemData();
      },
      child: Text(_navigationData[index].name),
    );
  }

  Widget _buildNavigationItem(int index) {
    var data = _navigationData[_selectItemIndex].articles[index];
    return RaisedButton(
      onPressed: () {
        Pages.openWebView(context, data.title, data.link);
      },
      child: Text(data.title),
    );
  }

}
