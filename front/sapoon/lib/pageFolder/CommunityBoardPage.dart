import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;





class CommunityBoardPage extends StatefulWidget {
  @override
  _CommunityBoardPageState createState() => _CommunityBoardPageState();
}


Future<List<Post>> getRandomFiveTrail(String region) async {
  final http.Response response = await http.get(
      Uri.encodeFull(
          'http://34.80.151.71/sapoon/promenade/dullegil/search/gu?guName='+region),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    print("지역구 나옵니다");

    return makePostList(json.decode(utf8.decode(response.bodyBytes)));

  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception();
  }
}

class _CommunityBoardPageState extends State<CommunityBoardPage> {

  static String region='';
  Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print('지역구는: '+message.message);
          getRandomFiveTrail(message.message);
        }),
  ].toSet();

  WebViewController webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsChannels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.24,
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Text(
              '둘레길 정보 ',
              style: TextStyle(
                fontFamily: "NanumSquareExtraBold",
                fontSize: 21.0,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height*0.45,
                  child:   WebView(
                    initialUrl: "http://34.80.151.71/sapoon/web/promenade/seoul",
                    javascriptMode: JavascriptMode.unrestricted,
                    javascriptChannels: jsChannels,
                  )
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                width: 300,
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03, ),
              ),
              Text(
                '    여기 어때요?',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),


              Container(
                width: 20000,
                height: MediaQuery.of(context).size.width * 0.41,
                child: ListView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                                  height:
                                  MediaQuery.of(context).size.width * 0.35,
                                  fit: BoxFit.fill,
                                  width:
                                  MediaQuery.of(context).size.width * 0.42),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '  이런 날씨에 도심 산책 여기 어때요?',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "NanumSquareExtraBold",
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.026,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRo93aJCVkzf3LytZ4x7npQ6c_yLz9hTl7BDg&usqp=CAU',
                                  height:
                                  MediaQuery.of(context).size.width * 0.35,
                                  fit: BoxFit.fill,
                                  width:
                                  MediaQuery.of(context).size.width * 0.42),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '  이런 날씨에 도심 산책 여기 어때요?',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "NanumSquareExtraBold",
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.026,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109050_710.jpg',
                                  height:
                                  MediaQuery.of(context).size.width * 0.35,
                                  fit: BoxFit.fill,
                                  width:
                                  MediaQuery.of(context).size.width * 0.42),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '  이런 날씨에 도심 산책 여기 어때요?',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "NanumSquareExtraBold",
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.026,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
