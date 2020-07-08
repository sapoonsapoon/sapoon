import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sapoon/walkRoute/seokchunWalk.dart';
import 'package:http/http.dart' as http;
import 'package:sapoon/widget/cardWidget.dart';

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
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(utf8.decode(response.bodyBytes));
    return Post.makePostList(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}

class Post {
  String trailUrl;
  String trailName;
  String trailDistance;
  String trailBriefContents;

  Post(
      {this.trailUrl,
      this.trailName,
      this.trailDistance,
      this.trailBriefContents});

  static List<Post> makePostList(List<dynamic> json) {
    List<Post> values = List<Post>() ;
    print(json.length);
    for (int i = 0; i < json.length; i++) {
      String trailsJsonName = json[i]['name'];
      String trailcourseName = json[i]['courseName'];
      print(trailcourseName);
      if (trailcourseName.length > 10) {
        trailcourseName = trailcourseName.substring(0, 9) + '...';
      }
      if (trailsJsonName.length > 10) {
        trailsJsonName = trailsJsonName.substring(0, 9) + '...';
      }
        //썸네일 사진이 없으면 임의로 넣어준다.
        values.add(
            Post(
          trailUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRo93aJCVkzf3LytZ4x7npQ6c_yLz9hTl7BDg&usqp=CAU',
          trailName: trailsJsonName+ '\n' + trailcourseName,
          trailDistance: '2km',
          trailBriefContents: json[i]['region1'],
        ));

    }
    return values;
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> trailCard;
  Future<List<Post>> post;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post = getPhotoUrl();

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.24,
              width: MediaQuery.of(context).size.width * 0.02,
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
              width: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.54,
              height: MediaQuery.of(context).size.width * 0.09,
              child: Container(
                child: new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "산책로 찾기",
                    labelStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: "NanumSquareExtraBold",
                        fontSize: 12.0),

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

                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Icon(Icons.search)
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
                      '\n영등포구 \n대체로 맑음 \n비 올 확율 13%',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.029),
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
                child:  FutureBuilder(
                  future: post,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index){
                            Post posts = snapshot.data[index];
                            print(index);
                            return CardWidget(
                              context: context,
                              trailDistance: posts.trailDistance,
                              trailUrl: posts.trailUrl,
                              trailName: posts.trailName,
                              briefContents: posts.trailBriefContents,
                            );
                          }
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),

//                ListView(
//                  padding: EdgeInsets.only(
//                      left: MediaQuery.of(context).size.width * 0.01),
//
//                  scrollDirection: Axis.horizontal,
//                ),
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
                      '오늘의 업데이트',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                          'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                          height: MediaQuery.of(context).size.height * 0.23,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.4),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          child: Text("가수 태연의 최애 산책로!",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("사회적 거리두기에 모두 동참이..!",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("연인과 걷고싶은 길 1위..",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("혼자 나만의 시간이 필요할 때",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("에너지가 넘치는 하루를..",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              )
            ],
          ),
        )),
      ),
    );
  }
}

//Future WalkTrail(
//    String id;
//    ) async {
//  final http.Response response = await http.post(
//    '',
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//    },
//    body: jsonEncode(<String,String>{
//        'id': '$id',
//      }),
//  );
//}
