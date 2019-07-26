

import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loadmore/loadmore.dart';

class ClassificationListPage extends StatefulWidget {

  final KnowledgeSystemBean rootBean;

  ClassificationListPage(this.rootBean);

  @override
  _ClassificationListState createState() => _ClassificationListState();

}

class _ClassificationListState extends State<ClassificationListPage> {

  List<HomeListDataBean> _classificationListData = [];

  int _listPageIndex = 0;

  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _requestKnowledgeSystemData(0);
  }

  Future<bool> _requestKnowledgeSystemData(int page) async {
    _listPageIndex = page;
    var data = await ApiRequester.getKnowledgeSystemChildren(page, widget.rootBean.id);
    print(data);
    if (data == null) {
      return false;
    }
    if (data.datas.isNotEmpty) {
      setState(() {
        _isLastPage = data.pageCount < 2 || data.over;
        if (page == 0) {
          _classificationListData.clear();
        }
        _classificationListData.addAll(data.datas);
      });
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appMainColor,
          title: Text(widget.rootBean.name),
          centerTitle: true,
        ),
        body: _classificationListData.isEmpty ? EmptyHolder() :_buildBody(),
    );
  }

  Widget _buildBody() {
    Widget list = ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) => _buildListItem(i),
      itemCount: _classificationListData == null ? 0 : _classificationListData.length,
//      controller: _scrollController,
    );

//    var _pullToRefreshWidget = LiquidPullToRefresh(
////        scrollController: _scrollController,
//      color: appMainColor,
//      onRefresh: ()=> _requestKnowledgeSystemData(0),
//      child: list,
//    );
//    return _pullToRefreshWidget;

    return LoadMore(
      isFinish: _isLastPage,
      onLoadMore: () => _requestKnowledgeSystemData(++_listPageIndex),
      textBuilder: (status) {
        if (status == LoadMoreStatus.nomore && _classificationListData.isEmpty) {
          return "暂无数据";
        }
        return DefaultLoadMoreTextBuilder.chinese(status);
      },
      child: list,
    );
  }

  Widget _buildListItem(int index) {
    HomeListDataBean data = _classificationListData[index];
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
            var data = _classificationListData[index];
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
