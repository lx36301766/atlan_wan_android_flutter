import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/widget/article_item_widget.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class GeneralArticleModel extends Model {
  static GeneralArticleModel of(BuildContext context) => ScopedModel.of<GeneralArticleModel>(context);

  GeneralArticleModel(this._name) {
    requestPageData(0);
  }

  String _name;
  List<HomeListDataBean> _generalArticleListData = [];

  int _listPageIndex = 0;
  bool _isLastPage = false;

  Future getData(int page);

  Future<bool> requestPageData(int page) async {
    var data = await getData(page);
    print(data);
    _listPageIndex = page;
    if (data.datas.isNotEmpty) {
      _isLastPage = data.pageCount < 2 || data.over;
      if (page == 0) {
        _generalArticleListData.clear();
      }
      _generalArticleListData.addAll(data.datas);
    }
    notifyListeners();
    return data != null;
  }

  Future<bool> nextPageData() async => requestPageData(++_listPageIndex);
}

class ClassificationModel extends GeneralArticleModel {

  int _id;

  ClassificationModel(String name, this._id) : super(name);

  @override
  Future getData(int page) => Api.getKnowledgeSystemChildren(page, _id);
}

class SearchResultModel extends GeneralArticleModel {

  SearchResultModel(String key) : super(key);

  @override
  Future getData(int page) => Api.getSearchResult(page, _name);
}





class GeneralArticleListPage<T extends GeneralArticleModel> extends StatefulWidget {
  @override
  _GeneralArticleListPageListState<T> createState() => _GeneralArticleListPageListState<T>();
}

class _GeneralArticleListPageListState<T extends GeneralArticleModel> extends State<GeneralArticleListPage<T>> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<T>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appMainColor,
          title: Text(model._name),
          centerTitle: true,
        ),
        body: model._generalArticleListData.isEmpty ? EmptyHolder() : _buildBody(model),
      );
    });
  }

  Widget _buildBody(GeneralArticleModel model) {
    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => ArticleItemWidget(model._generalArticleListData[i], i, -1),
      itemCount: model._generalArticleListData == null ? 0 : model._generalArticleListData.length,
//      controller: _scrollController,
    );

    return LoadMore(
      isFinish: model._isLastPage,
      onLoadMore: () => model.nextPageData(),
      textBuilder: (status) {
        if (status == LoadMoreStatus.nomore && model._generalArticleListData.isEmpty) {
          return "暂无数据";
        }
        return DefaultLoadMoreTextBuilder.chinese(status);
      },
      child: list,
    );
  }
}
