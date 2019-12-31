
import 'package:atlan_wan_android_flutter/entity/home_list_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/pages.dart';
import 'package:flutter/material.dart';

class ArticleItemWidget extends StatelessWidget {

  final HomeListDataBean data;
  final int index;
  final int topDataSize;

  ArticleItemWidget(this.data, this.index, this.topDataSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        child: InkWell(
          splashColor: Color(0xFF30f86F),
          highlightColor: appMainColor,
          onTap: () {
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Row(
                          children: <Widget>[
                            Visibility(
                              visible: data.fresh ?? false,
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
                              visible: index <= topDataSize,
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
                            Text("${data.author.isEmpty ? data.shareUser ?? "" : data.author}" +
                                (data.superChapterName?.isEmpty ?? true ?  "" : " • ${data.superChapterName}") +
                                " • ${data.chapterName}".trim(),
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
                        child: Text(data.niceDate,
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
    );
  }

}
