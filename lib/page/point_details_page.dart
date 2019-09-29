
import 'package:atlan_wan_android_flutter/entity/user_earn_points_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_rank_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/network/api_network.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_hour_glass_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class PointDetailsList extends StatelessWidget {

  final List<String> tabs = ['积分排行榜', '积分明细'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TabBar(tabs: List.generate(tabs.length, (index) => Tab(text: tabs[index]))),
        ),
        body: TabBarView(
          children: <Widget>[
            PointRankList(),
            PointEarnList(),
          ],
        ),
      ),
    );
  }

}


class PointEarnList extends PointDetailList {

  @override
  Future<UserEarnPointsListBean> _request(int page) async => Api.getUserEarnPointsList(page);

  @override
  Widget _getListItem(int index) {
    var item = _data[index];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(item.desc),
    );
  }

}

class PointRankList extends PointDetailList {

  @override
  Future<UserPointRankListBean> _request(int page) async => Api.getUserPointRankList(page);

  @override
  Widget _getListItem(int index) {
    var item = _data[index];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text("${index + 1}     ${item.username}   -  ${item.coinCount}"),
    );
  }

}

abstract class PointDetailList extends StatefulWidget with ChangeNotifier {

  List _data = List();

  int _pageIndex = 0;

  PointDetailList() {
    _requestData(0);
  }

  Future<dynamic> _request(int page);

  Widget _getListItem(int index);

  Future<void> _requestData(int page) async {
    print("_requestData, page=$page");
    if (page == 0) {
      _data.clear();
    }
    dynamic bean = await _request(page);
    if (bean != null) {
      _data.addAll(bean.datas);
      notifyListeners();
      return;
    }
    throw ApiError("_requestData error");
  }

  Future<void> _requestNextPage() async {
    _requestData(++_pageIndex);
  }

  @override
  _PointDetailListState createState() => _PointDetailListState();

}

class _PointDetailListState extends KeepAliveState<PointDetailList> {
  @override
  Widget build(BuildContext context) {
    return SinglePageProviderConsumer<PointDetailList>(
        model: widget,
        builder: (context, model, child) {
          int size = model._data?.length ?? 0;
          if (size == 0) {
            return Center(child: Text("empty"));
          }
          return Scrollbar(
            child: EasyRefresh(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              child: ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: Colors.black26),
                  padding: EdgeInsets.all(0),
                  itemCount: size,
                  itemBuilder: (context, index) => widget._getListItem(index)
              ),
              onRefresh: () => model._requestData(0),
              onLoad: () => model._requestNextPage(),
            ),
          );
        }
    );
  }
}







//class PointEarnModel extends ChangeNotifier {
//
//  PointEarnModel() {
//    _requestUserEarnPointsList(0);
//  }
//
//  UserEarnPointsListBean _userEarnPointsList;
//
//  int _pageIndex;
//
//  Future<void> _requestUserEarnPointsList(int page) async {
//    print("_requestUserEarnPointsList");
//    UserEarnPointsListBean bean = await Api.getUserEarnPointsList(page);
//    if (bean != null) {
//      _userEarnPointsList = bean;
//      notifyListeners();
//      return;
//    }
//    throw ApiError("getUserEarnPointsList error");
//  }
//
//  Future<void> _requestNextPage() async {
//    _requestUserEarnPointsList(++_pageIndex);
//  }
//
//}
//
//class PointEarnList extends StatefulWidget {
//  @override
//  _PointEarnListState createState() => _PointEarnListState();
//}
//
//class _PointEarnListState extends KeepAliveState<PointEarnList> {
//  @override
//  Widget build(BuildContext context) {
//    return SinglePageProviderConsumer<PointEarnModel>(
//        model: PointEarnModel(),
//        builder: (context, model, child) {
//          if (model?._userEarnPointsList?.datas == null) {
//            return Center(child: Text("_userEarnPointsList"));
//          }
//          return Scrollbar(
//            child: ListView.builder(
//                padding: EdgeInsets.all(15),
//                itemCount: model._userEarnPointsList.datas.length,
//                itemBuilder: (context, index) {
//                  var item = model._userEarnPointsList.datas[index];
//                  return Text(item.desc);
//                }),
//          );
//        }
//    );
//  }
//}
//
//
//
//class PointRankList extends StatefulWidget {
//  @override
//  _PointRankListState createState() => _PointRankListState();
//}
//
//
//class _PointRankListState extends KeepAliveState<PointRankList> {
//
//  @override
//  Widget build(BuildContext context) {
//    return SinglePageProviderConsumer<PointRankModel>(
//        model: PointRankModel(),
//        builder: (context, model, child) {
//          if (model?._userPointRankList?.datas == null) {
//            return Center(child: Text("_userPointRankList"));
//          }
//          return Scrollbar(
//            child: ListView.builder(
//                padding: EdgeInsets.all(15),
//                itemCount: model._userPointRankList.datas.length,
//                itemBuilder: (context, index) {
//                  var item = model._userPointRankList.datas[index];
//                  return Text("$index  ${item.username}"  "${item.coinCount}");
//                }),
//          );
//        }
//    );
//  }
//}
//
//
//class PointRankModel extends ChangeNotifier {
//
//  PointRankModel() {
//    _requestUserPointRankList(0);
//  }
//
//  UserPointRankListBean _userPointRankList;
//
//  int _pageIndex;
//
//  Future<void> _requestUserPointRankList(int page) async {
//    print("_requestUserPointRankList");
//    UserPointRankListBean bean = await Api.getUserPointRankList(page);
//    if (bean != null) {
//      _userPointRankList = bean;
//      notifyListeners();
//      return;
//    }
//    throw ApiError("getUserPointRankList error");
//  }
//
//  Future<void> _requestNextPage() async {
//    _requestUserPointRankList(++_pageIndex);
//  }
//
//}
