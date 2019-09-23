

import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/widget/article_item_widget.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:scoped_model/scoped_model.dart';


class ClassificationModel extends Model {

  static ClassificationModel of(BuildContext context) => ScopedModel.of<ClassificationModel>(context);

  ClassificationModel(this._rootBean) {
    requestPageData(0);
  }

  KnowledgeSystemBean _rootBean;
  List<HomeListDataBean> _classificationListData = [];

  int _listPageIndex = 0;
  bool _isLastPage = false;

  Future<bool> requestPageData(int page) async {
    var data = await Api.getKnowledgeSystemChildren(page, _rootBean.id);
    print(data);
    _listPageIndex = page;
    if (data.datas.isNotEmpty) {
      _isLastPage = data.pageCount < 2 || data.over;
      if (page == 0) {
        _classificationListData.clear();
      }
      _classificationListData.addAll(data.datas);
    }
    notifyListeners();
    return data != null;
  }

  Future<bool> nextPageData() async => requestPageData(++_listPageIndex);

}


class ClassificationListPage extends StatefulWidget {

  @override
  _ClassificationListState createState() => _ClassificationListState();

}

class _ClassificationListState extends State<ClassificationListPage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ClassificationModel>(
        builder: (context, child, model) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: appMainColor,
              title: Text(model._rootBean.name),
              centerTitle: true,
            ),
            body: model._classificationListData.isEmpty ? EmptyHolder() : _buildBody(model),
          );
        });
  }

  Widget _buildBody(ClassificationModel model) {
    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => ArticleItemWidget(model._classificationListData[i], i, -1),
      itemCount: model._classificationListData == null ? 0 : model._classificationListData.length,
//      controller: _scrollController,
    );

    return LoadMore(
      isFinish: model._isLastPage,
      onLoadMore: () => model.nextPageData(),
      textBuilder: (status) {
        if (status == LoadMoreStatus.nomore && model._classificationListData.isEmpty) {
          return "暂无数据";
        }
        return DefaultLoadMoreTextBuilder.chinese(status);
      },
      child: list,
    );
  }

}
