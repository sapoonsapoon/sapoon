import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/pageFolder/destinationPage.dart';
import 'package:sapoon/pageFolder/productPage.dart';
import 'package:sapoon/pageFolder/trailDetailPage.dart';
import 'package:sapoon/pageFolder/trailEditPage.dart';
import 'package:sapoon/walkRoute/seokchunWalk.dart';
import 'package:http/http.dart' as http;
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/cardWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<List<Post>> getPhotoUrl() async {
  final http.Response response = await http.get(
      Uri.encodeFull(
          'http://35.201.203.73/sapoon/promenade/dullegil/main/recommend/random'),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return makePostList(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception();
  }
}

Future<List<Post>> getWeather() async {
  final http.Response response = await http.get(
      Uri.encodeFull(
          'http://35.201.203.73/sapoon/promenade/dullegil/main/recommend/random'),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {;
    return makePostList(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}

Future<List> getPosition() async {
  var currentPosition = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List latitudeLongitudes = new List();
  latitudeLongitudes.add(currentPosition.latitude);
  latitudeLongitudes.add(currentPosition.longitude);
  return latitudeLongitudes;
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> trailCard;
  Future<List<Post>> post;
  Future<List> geoResult;

  List<String> myList = ["foo", "bar"];


  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  void myFunction(String text) {
    print(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    post = getPhotoUrl();
    geoResult = getPosition();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.24,
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            InkWell(
              onTap: () {
                getPhotoUrl();
              },
              child: Text(
                'SAPOON',
                style: TextStyle(
                  fontFamily: "NanumSquareExtraBold",
                  fontSize: 19.0,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.24,
              width: MediaQuery.of(context).size.width * 0.16,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.54,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Container(
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    cursorWidth: 1,
                    style: TextStyle(fontFamily: 'NanumSquareRegular'),
                    decoration: InputDecoration(
                        labelText: "산책로 찾기",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: 10.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0XFFA3C0F1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0XFFA3C0F1),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        hintStyle: TextStyle(fontSize: 9),
                        hintText: '마음에 드는 산책로가 있나요?'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await BackendService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Image.network(
                          'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg'),
                      title: Text(
                        suggestion['name'],
                        style: TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        suggestion['trailDistance'],
                        style: TextStyle(fontSize: 12, color: Colors.green),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    List showList =new List();
                    showList.add(suggestion['name']);
                    showList.add(suggestion['trailDistance']);
                    showList.add(suggestion['trailUrl']);
                    showList.add(suggestion['trailBriefContents']);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TrailEditPage(activity: showList)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.09,
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Text(
                      '홍길동님',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.14,
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Text(
                      '산책하기 \n정말 좋은 날씨에요!',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.06),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Icon(
                      Icons.wb_sunny,
                      color: Colors.orangeAccent,
                      size: 70,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      '\n영등포구 \n대체로 맑음\n 강수 13%',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.025),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                width: 20000,
                height: MediaQuery.of(context).size.width * 0.75,
                child: FutureBuilder(
                  future: post,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            Post posts = snapshot.data[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DestinationPage(
                                            posts: posts,
                                          ))),
                              child: CardWidget(
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
                    return CircularProgressIndicator(
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: 300,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      '\t 오늘의 산책',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: FutureBuilder(
                  future: post,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            Post posts = snapshot.data[0];
                            Activity activity = posts.activities[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrailDetailPage(
                                        activity: activity,
                                      ))),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                                    height: MediaQuery.of(context).size.height*0.17,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 170.0,
                                                child: Text(
                                                  activity.name,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    '\*${activity.price}',
                                                    style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Total',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 170.0,
                                            child: Text(
                                              activity.type,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 2.0),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              _buildRatingStars(activity.rating),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 100.0,
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  activity.startTimes[0] +'~' +activity.startTimes[1],
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20.0,
                                    top: 15.0,
                                    bottom: 15.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        width: 110.0,
                                        image: AssetImage(
                                          activity.imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator(
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

