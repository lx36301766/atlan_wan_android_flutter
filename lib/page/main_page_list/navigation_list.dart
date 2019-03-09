
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/navigation_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
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
    Widget list1 = ListView.separated(
      itemBuilder: (context, i) => _buildNavigation(i),
      separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: Colors.black26),
      itemCount: _navigationData?.length,
    );

    Widget list2 = ListView.separated(
      itemBuilder: (context, i) => _buildNavigationItem(i),
      separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: appIconColor),
      itemCount: _navigationData.length > _selectItemIndex ?
              _navigationData[_selectItemIndex].articles.length : 0,
      controller: _scrollController,
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: list1,
          ),
          flex: 1,
        ),
//        VerticalDivider(width: 2.0,color: appIconColor),
        Expanded(
          child: Scrollbar(
            child: list2,
          ),
          flex: 2,
        ),
      ],
    );
  }

  Widget _buildNavigation(int index) {
    return Ink(
      color: index == _selectItemIndex ? Colors.white: Colors.grey.shade200,
      child: ListTile(
        title: Center(child: Text(_navigationData[index].name)),
        dense: true,
        selected: false,
        onTap: () {
          _selectItemIndex = index;
          _requestKnowledgeSystemData();
        },
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    var data = _navigationData[_selectItemIndex].articles[index];
    return InkWell(
      splashColor: Color(0xFFf0f8FF),
      highlightColor: appIconColor,
      onTap: () {
        Pages.openWebView(context, data.title, data.link);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(data.title,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

}
