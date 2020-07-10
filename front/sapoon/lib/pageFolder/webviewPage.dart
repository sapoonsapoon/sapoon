import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text("hiiiiiiiiiiiii "),
    Text("hiiiiiiiiiiiii "),
    Container(
    height: 300,
    child: WebView(
    key: Key("webview1"),
    debuggingEnabled: true,
    javascriptMode: JavascriptMode.unrestricted,
    initialUrl: "https://flutter.dev/")
    ),
    Text("hiiiiiiiiiiiii "),
    Text("hiiiiiiiiiiiii "),]
    );
  }
}
