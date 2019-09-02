
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/custom_expansion_tile.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class KnowledgeSystemListPage extends StatefulWidget {

  @override
  _KnowledgeSystemListPageState createState() => _KnowledgeSystemListPageState();

}

class _KnowledgeSystemListPageState extends KeepAliveState<KnowledgeSystemListPage> {

  var _knowledgeSystemData = <KnowledgeSystemBean>[];

  @override
  void initState() {
    super.initState();
    _requestKnowledgeSystemData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _requestKnowledgeSystemData() async {
    List<KnowledgeSystemBean> data = await Api.getKnowledgeSystem();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _knowledgeSystemData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_knowledgeSystemData.isEmpty) {
      return EmptyHolder();
    }
    Widget list = ListView.builder(
      itemBuilder: (context, i) => _buildItem(_knowledgeSystemData[i]),
      itemCount: _knowledgeSystemData.length,
//      controller: _scrollController,
    );

//    var _pullToRefreshWidget = NotificationListener<ScrollNotification>(
//      onNotification: (scrollNotification) => false,
//      // RefreshIndicator / LiquidPullToRefresh
//      child: LiquidPullToRefresh(
//        color: appIconColor,
//        onRefresh: _pullToRefresh,
//        child: list,
//      ),
//    );
    return list;
  }

  // Future<void> _pullToRefresh() async {
  //   _requestKnowledgeSystemData();
  //   return null;
  // }

//  PageStorageKey<_KnowledgeSystemListPageState> _key = PageStorageKey();

  RandomColor _randomColor = RandomColor();

  Widget _buildItem(KnowledgeSystemBean data) {

//    for (KnowledgeSystemBean itemBean in data.children) {
//      titles.add(Divider());
//      titles.add( ListTile(
//        onTap: () {},
//        dense: true,
//        contentPadding: EdgeInsets.symmetric(horizontal: 0),
//        title: Container(
//          child: Center(
//            child: Text(itemBean.name,
//              style: TextStyle(
//                fontSize: 13.0,
//                fontStyle: FontStyle.normal,
//                wordSpacing: 5.0,
//              ),),
//          ),
//        ),
//      ));
//    }
    return Column(
      children: <Widget>[
        CustomExpansionTile(
          key: PageStorageKey<KnowledgeSystemBean>(data),
          leading: Icon(Icons.reorder, color: appMainColor),
          title: Text(data.name,
            style: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              wordSpacing: 5.0,
            ),
          ),
          children: <Widget>[
            // Divider(color: appMainColor),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 6, top: 2),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                children: data.children.map((itemData) {
                  return ActionChip(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: _randomColor.randomColor(colorBrightness: ColorBrightness.light),
                    shadowColor: appMainColor,
                    label: Text(itemData.name, style: TextStyle(fontSize: 12.0)),
                    onPressed: () {
                      Pages.openClassificationList(context, itemData);
                    },
                  );
//                  return InkWell(
//                    child: Container(
//                      child: Text(itemData.name, style: TextStyle(color: appIconColor, fontSize: 13.0)),
//                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
//                    ),
//                    onTap: () {
//
//                    },
//                  );
                }).toList(),
              ),
            )
          ],
        ),
//        Divider(
//          color: appIconColor,
//          height: 3,
//        )
      ],
    );
  }

}
