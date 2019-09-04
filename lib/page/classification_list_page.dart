

import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
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
      itemBuilder: (context, i) => _buildListItem(i, model),
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

  Widget _buildListItem(int index, ClassificationModel model) {
    HomeListDataBean data = model._classificationListData[index];
    data.title = htmlUnescape.convert(data.title);
    return Container(
//      color: Colors.blue,
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 5.0,
        child: InkWell(
          splashColor: Color(0xFFf0f8FF),
          highlightColor: appMainColor,
          onTap: () {
            var data = model._classificationListData[index];
            Pages.openWebView(context, data.title, data.link);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:5, horizontal:12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(data.title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 5.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Text("${data.author} / ${data.superChapterName}-${data.chapterName}",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 2.0,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(data.niceDate,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            wordSpacing: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
