
import 'dart:async';

import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/navigation_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:flutter/material.dart';

class NavigationModel extends ChangeNotifier {

  var _navigationData = <NavigationBean>[];

  int _selectItemIndex = 0;

  Future<void> _requestKnowledgeSystemData() async {
    List<NavigationBean> data = await Api.getNavigation();
    print(data);
    if (data != null && data.length > 0) {
      _navigationData = data;
      notifyListeners();
    }
  }

  void setSelectItemIndex(int index) {
    _selectItemIndex = index;
    notifyListeners();
  }

  int getChildItemCount() {
    return _navigationData.length > _selectItemIndex ? _navigationData[_selectItemIndex].articles.length : 0;
  }

  @override
  void dispose() {
    super.dispose();
    print("NavigationModel dispose");
  }

}


class NavigationListPage extends StatefulWidget {

  @override
  _NavigationListPageState createState() => _NavigationListPageState();

}

class _NavigationListPageState extends KeepAliveState<NavigationListPage> {

  ScrollController _scrollController;
  NavigationModel _model;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _model = NavigationModel().._requestKnowledgeSystemData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SinglePageProviderConsumer<NavigationModel>(
      model: _model,
      builder: (context, model, child) {
        return model._navigationData.isEmpty ? EmptyHolder() : Row(
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  itemBuilder: (context, i) => _buildNavigation(i, model),
                  separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: Colors.black26),
                  itemCount: model._navigationData?.length,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  itemBuilder: (context, i) => _buildNavigationItem(model._navigationData[model._selectItemIndex].articles[i]),
                  separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: appMainColor),
                  itemCount: model.getChildItemCount(),
                  controller: _scrollController,
                ),
              ),
              flex: 2,
            ),
          ],
        );
      }
    );
  }

  Widget _buildNavigation(int index, NavigationModel model) {
    return Ink(
      color: index == model._selectItemIndex ? Colors.white: Colors.grey.shade200,
      child: ListTile(
        title: Center(child: Text(model._navigationData[index].name)),
        dense: true,
        selected: false,
        onTap: () {
          if (model._selectItemIndex != index) {
            model.setSelectItemIndex(index);
            _scrollController.jumpTo(0);
          }
        },
      ),
    );
  }

  Widget _buildNavigationItem(HomeListDataBean data) {
    return InkWell(
      splashColor: Color(0xFFf0f8FF),
      highlightColor: appMainColor,
      onTap: () => Pages.openWebView(context, data.title, data.link),
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
