import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchHotKeyModel extends Model {
  static SearchHotKeyModel of(BuildContext context) => ScopedModel.of<SearchHotKeyModel>(context);

  List<String> _hotKeys = List();

  Future getSearchHotKey() async {
    var data = await Api.getSearchHotKey();
    _hotKeys = data.map((keyBean) => keyBean.name).toList();
    notifyListeners();
    print("getSearchHotKey");
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
  Widget build(BuildContext context) {
    print("_SearchPageState build");
    SearchHotKeyModel.of(context).getSearchHotKey();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
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
                      Navigator.pop(context);
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
                        Pages.openSearchResultListPage(context, text);
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
            Text(
              "搜索热词",
              style: TextStyle(),
            ),
            ScopedModelDescendant<SearchHotKeyModel>(builder: (context, child, model) {
              print("model=$model");
              return Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                children: model._hotKeys.map((key) => ActionChip(
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          backgroundColor: randomColor.randomColor(colorBrightness: ColorBrightness.light),
                          shadowColor: appMainColor,
                          label: Text(key, style: TextStyle(fontSize: 12.0)),
                          onPressed: () {

                          },
                        )).toList(),
              );
            }),
//            Text(
//              "搜索历史",
//              style: TextStyle(),
//            ),
//            ScopedModelDescendant<SearchHotKeyModel>(builder: (context, child, model) {
//              print("456");
//              return Wrap(
//                spacing: 8.0,
//                runSpacing: 0.0,
//                alignment: WrapAlignment.start,
//                children: model._hotKeys.map((key) => ActionChip(
//                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
//                          backgroundColor: randomColor.randomColor(colorBrightness: ColorBrightness.light),
//                          shadowColor: appMainColor,
//                          label: Text(key, style: TextStyle(fontSize: 12.0)),
//                          onPressed: () {},
//                        )).toList(),
//              );
//            }),
          ],
        ),
      ),
    );
  }
}
