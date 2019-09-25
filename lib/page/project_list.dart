
import 'dart:async';
import 'dart:collection';

import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/knowledge_system_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:atlan_wan_android_flutter/widget/unescape_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class ProjectListModel extends ChangeNotifier {

  var _projectData = <KnowledgeSystemBean>[];

  int _selectedItemIndex = 0;

  var _listPageIndexes;

  bool _isLastPage = false;

  Map<int, Set<HomeListDataBean>> _homeListBeans = {};

  Future<void> _requestProjectData() async {
    List<KnowledgeSystemBean> data = await Api.getProject();
    print(data);
    if (data != null && data.length > 0) {
      _projectData = data;
      _listPageIndexes = List.generate(_projectData.length,  (int index) => 1);
      notifyListeners();
      _requestProjectListData(_selectedItemIndex);
    }
  }

  Future<bool> _requestProjectListData(int index) async {
    HomeListBean dataBean = await Api.getProjectList(_listPageIndexes[index], _projectData[index].id);
    print(dataBean);
    if (dataBean == null) {
      return false;
    }
    _isLastPage = dataBean.pageCount < 2 || dataBean.over;
    print("_isLastPage=$_isLastPage");
    if (_homeListBeans[index] == null) {
      _homeListBeans[index] = LinkedHashSet<HomeListDataBean>();
    }
    if (dataBean.datas != null && dataBean.datas.length > 0) {
      _listPageIndexes[index]++;
      _homeListBeans[index].addAll(dataBean.datas);
    }
    notifyListeners();
    return true;
  }

  Future<bool> _requestCurrentProjectListData() async => _requestProjectListData(_selectedItemIndex);

  void onTabChange(int index) {
    _selectedItemIndex = index;
    _requestProjectListData(_selectedItemIndex);
  }

}



class ProjectListPage extends StatefulWidget {

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends KeepAliveState<ProjectListPage> with TickerProviderStateMixin {

  TabController _tabController;

  ProjectListModel _model;

  @override
  void initState() {
    super.initState();
    _model = ProjectListModel().._requestProjectData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SinglePageProviderConsumer<ProjectListModel>(
      model: ProjectListModel().._requestProjectData(),
      builder:(context, model, child) {
        var length = model._projectData.length;
        if (length > 0) {
          this._model = model;
          if (_tabController == null) {
            _tabController = TabController(length: _model._projectData.length, vsync: this)..addListener(() {
              if (_tabController.index.toDouble() == _tabController.animation.value) {
                print("change selected tab index = ${_tabController.index}");
                _model.onTabChange(_tabController.index);
              }
            });
          }
          return Scaffold(
            appBar: _buildPageSlider(List.generate(length, (int index) => UnescapeTab(text: model._projectData[index].name))),
            body: TabBarView(
              controller: _tabController,
              children: List.generate(length, (int index) => _buildContent(model, index)),
            ),
          );
        } else {
          return EmptyHolder();
        }
      }
    );
  }

  Widget _buildPageSlider(List<Tab> tabs) {
    return PreferredSize(
      preferredSize: Size.fromHeight(35.0),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.black38,
          indicatorWeight: 1.0,
          indicatorColor: appMainColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: appMainColor,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }

  Widget _buildContent(ProjectListModel model, int index) {
    Set<HomeListDataBean> dataSet = model._homeListBeans[index];
    if (dataSet == null) {
      return EmptyHolder();
    } else {
      List<HomeListDataBean> data = List.from(dataSet);
      return KeepAliveStateContainer(
        child: LoadMore(
          isFinish: model._isLastPage,
          onLoadMore: ()=> model._requestCurrentProjectListData(),
          textBuilder: (status) {
            if (status == LoadMoreStatus.nomore && data.isEmpty) {
              return "暂无数据";
            }
            return DefaultLoadMoreTextBuilder.chinese(status);
          },
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) => _buildCardItem(data[i]),
            itemCount: data.length,
          ),
        ),
      );
    }
  }

  Widget _buildCardItem(HomeListDataBean dataBean) {
    var name = "${dataBean.author}-${dataBean.chapterName}";
    return AspectRatio(
      key: PageStorageKey(dataBean),
      aspectRatio: 5 / 2,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFFf0f8FF),
            highlightColor: appMainColor,
            onTap: () => Pages.openWebView(context, dataBean.title, dataBean.link),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UnescapeText(dataBean.title,
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: UnescapeText(dataBean.desc,
                              style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(name, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                              Text(dataBean.niceDate, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(appMainColor),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: dataBean.envelopePic,
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

}
