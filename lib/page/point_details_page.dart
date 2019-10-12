
import 'package:atlan_wan_android_flutter/entity/user_earn_points_list_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_bean.dart';
import 'package:atlan_wan_android_flutter/entity/user_point_rank_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/network/api_network.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/util/storage_utils.dart';
import 'package:atlan_wan_android_flutter/widget/single_page_provider_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/bezier_hour_glass_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/taurus_footer.dart';

class PointDetailsList extends StatelessWidget {

  final List<String> tabs = ['积分排行榜', '积分明细'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.black38,
              indicatorWeight: 2.0,
              indicatorColor: appMainColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.symmetric(vertical: 1),
              labelColor: appMainColor,
              tabs: List.generate(tabs.length, (index) => Tab(text: tabs[index]))
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _PointRankList(),
            _PointEarnList(),
          ],
        ),
      ),
    );
  }

}


class _PointEarnList extends _PointDetailList<UserEarnPointsListBean, UserEarnPointsListBeanItem> {

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

class _PointRankList extends _PointDetailList<UserPointRankListBean, UserPointBean> {

  @override
  Future<UserPointRankListBean> _request(int page) async => Api.getUserPointRankList(page);

  @override
  Widget _getListItem(int index) {
    var item = _data[index];
    String name = StorageUtils.getUserInfo()?.username?.replaceRange(1, 3, "**");
    bool isMine = name == item.username;
    print("_getListItem, name=$name");
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text("${index + 1}     ${item.username}   -  ${item.coinCount}",
          style: TextStyle(
            color: isMine ? Colors.red : Colors.black
          ),
      ),
    );
  }

}

abstract class _PointDetailList<T, I> extends StatefulWidget with ChangeNotifier {

  List<I> _data = List();

  int _pageIndex = 0;

  _PointDetailList() {
    _requestData(0);
  }

  Future<T> _request(int page);

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

class _PointDetailListState extends KeepAliveState<_PointDetailList> {
  @override
  Widget build(BuildContext context) {
    return SinglePageProviderConsumer<_PointDetailList>(
        model: widget,
        builder: (context, model, child) {
          int size = model._data?.length ?? 0;
          if (size == 0) {
            return Center(child: Text("empty"));
          }
          return Scrollbar(
            child: EasyRefresh(
              header: BezierCircleHeader(
                backgroundColor: appMainColor,
              ),
              footer: TaurusFooter(
//                backgroundColor: appMainColor,
              ),
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
