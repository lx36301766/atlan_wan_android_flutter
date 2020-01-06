
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/network/api.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:atlan_wan_android_flutter/util/storage_utils.dart';
import 'package:atlan_wan_android_flutter/util/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleItemModel extends ChangeNotifier {

  final HomeListDataBean data;
  final int index;
  final int topDataSize;

  ArticleItemModel(this.data, this.index, this.topDataSize);

  void updateCollectStatus(bool collect) {
    data.collect = collect;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print("ArticleItemModel dispose");
  }

}


class ArticleItemWidget extends StatefulWidget {

  final ArticleItemModel _model;

  ArticleItemWidget(HomeListDataBean data, int index, int topDataSize): _model = ArticleItemModel(data, index, topDataSize);

  @override
  _ArticleItemWidgetState createState() => _ArticleItemWidgetState();

}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget._model,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          child: InkWell(
            splashColor: Color(0xFF30f86F),
            highlightColor: appMainColor,
            onTap: () {
              Pages.openWebView(context, widget._model.data.title, widget._model.data.link);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:5, horizontal:12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 8,
                        child: Row(
                          children: <Widget>[
                            Visibility(
                              visible: widget._model.data.fresh ?? false,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text("新",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.wavy,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: widget._model.index <= widget._model.topDataSize,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset('image/top.png',
                                  fit: BoxFit.none,
                                  width: 15,
                                  height: 15,
                                  scale: 7.0,
                                ),
                              ),
                            ),
                            Text(widget._model.data.author.isEmpty ? widget._model.data.shareUser ?? "" : widget._model.data.author,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                                wordSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            if (StorageUtils.isLogin) {
                              if (widget._model.data.collect ?? false) {
                                Api.deleteCollect(widget._model.data.id).then((resp) {
                                  widget._model.updateCollectStatus(false);
                                });
                              } else {
                                Api.addCollectInside(widget._model.data.id).then((resp) {
                                  widget._model.updateCollectStatus(true);
                                });
                              }
                            } else {
                              ToastUtil.show("请先登录");
                            }
                          },
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Consumer<ArticleItemModel>(
                              builder: (context, value, child) {
                                return Image.asset(value.data.collect ?? false ? "image/uncollect.png" : "image/collect.png",
                                  fit: BoxFit.none,
                                  width: 15,
                                  height: 15,
                                  scale: 7.0,
                                );
                              }
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 5),
                    child: Text(widget._model.data.title,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        wordSpacing: 5.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          child: Row(
                            children: <Widget>[
                              Text((widget._model.data.superChapterName?.isEmpty ?? true ?
                              "${widget._model.data.chapterName}".trim() :
                              "${widget._model.data.superChapterName} • ${widget._model.data.chapterName}").trim(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400,
                                  wordSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(widget._model.data.niceDate,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                              wordSpacing: 1.5,
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
      ),
    );
  }

}
