import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/util/storage_utils.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchKeyModel extends Model {
  
  static final SearchKeyModel _singleton = SearchKeyModel._internal();

  factory SearchKeyModel() => _singleton;

  SearchKeyModel._internal();
  
  List<String> _hotKeys = List();
  
  List<String> _historyKeys = List();

  Future getSearchHotKey() async {
    var data = await Api.getSearchHotKey();
    _hotKeys = data.map((keyBean) => keyBean.name).toList();
    notifyListeners();
    print("getSearchHotKey");
  }

  void getHistoryKey() async {
    _historyKeys = StorageUtils.getSearchHistory();
    notifyListeners();
    print("getHistoryKey, _historyKeys=$_historyKeys");
  }

}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SearchKeyModel().getSearchHotKey();
    SearchKeyModel().getHistoryKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_SearchPageState didChangeDependencies");
  }

  @override
  void didUpdateWidget(SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_SearchPageState didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("_SearchPageState dispose");
  }

  void openSearchResult(String key) {
    Pages.openSearchResultListPage(context, key, ()=> SearchKeyModel().getHistoryKey());
    StorageUtils.saveSearchHistory(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: TextField(
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                      prefixIcon: Icon(FontAwesomeIcons.search),
                      hintText: '请输入搜索内容',
                    ),
                    onSubmitted: (text) {
                      if (text.isEmpty) {
                        ToastUtil.show("请输入搜索内容");
                        FocusScope.of(context).requestFocus(_searchFocusNode);
                      } else {
                        openSearchResult(text);
                      }
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "搜索热词",
                style: TextStyle(),
              ),
            ),
            ScopedModelDescendant<SearchKeyModel>(builder: (context, child, model) {
              return Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                children: model._hotKeys.map((key) => ActionChip(
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          backgroundColor: appMainColor,
                          label: Text(key, style: TextStyle(fontSize: 12.0)),
                          onPressed: ()=> openSearchResult(key),
                        ))
                    .toList(),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "搜索历史",
                style: TextStyle(),
              ),
            ),
            ScopedModelDescendant<SearchKeyModel>(builder: (context, child, model) {
              return Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                children: model._historyKeys.map((key) => ActionChip(
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          shadowColor: appMainColor,
                          label: Text(key, style: TextStyle(fontSize: 12.0)),
                          onPressed: ()=> openSearchResult(key),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
