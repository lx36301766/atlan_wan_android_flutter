
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/widget/unescape_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage2 extends StatefulWidget {

  final String title;
  final String url;

  WebViewPage2({this.title, this.url});

  @override
  _WebViewPageState2 createState() => _WebViewPageState2();
}

class _WebViewPageState2 extends State<WebViewPage2> {

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        backgroundColor: appMainColor,
        title: UnescapeText(widget.title),
        leading: BackButton(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.collections),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () {
              launch(widget.url);
            },
          ),
        ],
//        actions: <Widget>[
//          PopupMenuButton(
//            icon: Icon(Icons.more_vert, color: appIconColor),
//            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
//              PopupMenuItem<String>(child: const Icon(Icons.collections, color: appIconColor)),
//              PopupMenuItem<String>(child: const Icon(Icons.open_in_browser, color: appIconColor)),
//            ],
//            onSelected: _onPopMenuSelected),
//        ],
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }

}
