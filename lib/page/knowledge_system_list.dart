
import 'dart:async';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/custom_expansion_tile.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class KnowledgeSystemModel extends ChangeNotifier {

  var _knowledgeSystemData = <KnowledgeSystemBean>[];

  Future<void> _requestKnowledgeSystemData() async {
    List<KnowledgeSystemBean> data = await Api.getKnowledgeSystem();
    print(data);
    if (data != null && data.length > 0) {
      _knowledgeSystemData = data;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("KnowledgeSystemModel dispose");
  }

}


class KnowledgeSystemListPage extends StatefulWidget {

  @override
  _KnowledgeSystemListPageState createState() => _KnowledgeSystemListPageState();

}

class _KnowledgeSystemListPageState extends KeepAliveState<KnowledgeSystemListPage> {

  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("_KnowledgeSystemListPageState build");
    return SinglePageProviderConsumer<KnowledgeSystemModel>(
      model: KnowledgeSystemModel().._requestKnowledgeSystemData(),
      builder: (context, model, child) {
        return model._knowledgeSystemData.isEmpty ? EmptyHolder() : ListView.builder(
          itemBuilder: (context, i) => _buildItem(model._knowledgeSystemData[i]),
          itemCount: model._knowledgeSystemData.length,
//      controller: _scrollController,
        );
      }
    );
  }

  Widget _buildItem(KnowledgeSystemBean data) {
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
                }).toList(),
              ),
            )
          ],
        ),
      ],
    );
  }

}
