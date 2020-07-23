import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/pageFolder/destinationPage.dart';
import 'package:sapoon/provider/regionProvider.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/cardRegionWidget.dart';
import 'package:sapoon/widget/cardWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class CommunityBoardPage extends StatefulWidget {
  CommunityBoardPage({Key key}):super(key:key);
  @override
  _CommunityBoardPageState createState() => _CommunityBoardPageState();
}

Future<List<Post>> getRegionAllTrail(String region) async {
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


Future<List<Post>> getRandomFiveTrail() async {
  final http.Response response = await http.get(
      Uri.encodeFull(
          'http://34.80.151.71/sapoon/promenade/dullegil/main/recommend/random'),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return makePostList(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception();
  }
}


class _CommunityBoardPageState extends State<CommunityBoardPage> {

  int _seconds = 1;
  RegionProvider _regionProvider;
  String region='';
  Future<List<Post>> regionCard;
  Future<List<Post>> randomFive;
  List<Post> countPost = new List<Post>();
  WebViewController webViewController;
  int secondsToDisplay = 0;

  jsChannels(BuildContext context , dynamic provider) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          print('지역구는: ' + message.message);
          provider.setCurrentIndex(message.message);
          getRegionAllTrail(message.message);
          print('setstate');
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    regionCard = getRegionAllTrail("종로구");
    randomFive = getRandomFiveTrail();
  }

  Widget futureBuilder(){
    return FutureBuilder(
      future: regionCard,
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          countPost = snapshot.data;
          return ListView.builder(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              scrollDirection: Axis.horizontal,
              itemCount: countPost.length,
              itemBuilder: (context, index) {
                Post posts = snapshot.data[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DestinationPage(
                            posts: posts,
                          ))),
                  child: cardRegionWidget(
                    context: context,
                    trailDistance: posts.trailDistance,
                    trailUrl: posts.trailUrl,
                    trailName: posts.trailName,
                    briefContents: posts.trailBriefContents,
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }


  Widget regionFutureBuilder(){
    return FutureBuilder(
      future: randomFive,
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          countPost = snapshot.data;
          return ListView.builder(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              scrollDirection: Axis.horizontal,
              itemCount: countPost.length,
              itemBuilder: (context, index) {
                Post posts = snapshot.data[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DestinationPage(
                            posts: posts,
                          ))),
                  child: cardRegionWidget(
                    context: context,
                    trailDistance: posts.trailDistance,
                    trailUrl: posts.trailUrl,
                    trailName: posts.trailName,
                    briefContents: posts.trailBriefContents,
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _regionProvider = Provider.of<RegionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
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
                    javascriptChannels: <JavascriptChannel>[
                      jsChannels(context , _regionProvider),
                    ].toSet(),
                  )
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                width: 300,
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      " 지역구별 산책로  " ,
                      style: TextStyle(
                          color: Colors.amber,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                    FlatButton.icon(onPressed: (){
                      regionCard = getRegionAllTrail(_regionProvider.currentRegion());
                      setState(() {
                        _seconds++;
                      });
                    }, icon: Icon(Icons.search ,color: Colors.green,), label: Text("\("+_regionProvider.currentRegion() +"\)"+' 조회하기', style: TextStyle(color: Colors.green),) ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03, ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.36,
                child: futureBuilder(),
              ),
              Divider(

              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01, ),
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      " 실시간 인기 산책로 (Top 5) " ,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context).size.width * 0.035),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03, ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.19,
                child: regionFutureBuilder(),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

