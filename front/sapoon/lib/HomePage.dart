import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

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
            Text(
              'SAPOON',
              style: TextStyle(
                fontFamily: "NanumSquareExtraBold",
                fontSize: 19.0,
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
                      size: 50,
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
                child: ListView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                                  height:
                                      MediaQuery.of(context).size.width * 0.55,
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '한강시민공원',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                    ),
                                    Text(
                                      ' 2km',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Text(
                                  '이런 날씨에 도심 산책\n여기 어때요?',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "NanumSquareRegular",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
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
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'https://lh3.googleusercontent.com/proxy/30TFzG89vcMmdFFlA_VUMaYvILI6k6o0WbLGJVaLtgPhggoBN5N-ABSHYhBBAr_vHplJGaetYEbGWOuZxHbKWcaqoAYrqEin5HJvsbtEgV-uPcU4mzec3rb7Sz-a9nEqSGIbanm8qq_3VfMnmGxUWw',
                                  height:
                                      MediaQuery.of(context).size.width * 0.55,
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '석촌호수',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                    ),
                                    Text(
                                      ' 4km',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                ),
                                Text(
                                  '연인이랑 손잡고\n여기 산책해볼까요?',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "NanumSquareRegular",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
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
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109050_710.jpg',
                                  height:
                                      MediaQuery.of(context).size.width * 0.55,
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '임사생태공원\n생태산책길',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                    ),
                                    Text(
                                      '1km',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: "NanumSquareExtraBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Text(
                                  '나만의 시간\n이 길을 걸어볼까요?',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "NanumSquareRegular",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
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
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                                  height:
                                      MediaQuery.of(context).size.width * 0.63,
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                  'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                                  height:
                                      MediaQuery.of(context).size.width * 0.63,
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  scrollDirection: Axis.horizontal,
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
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                          'http://www.greenpostkorea.co.kr/news/photo/201910/110448_109048_423.jpg',
                          height:
                          MediaQuery.of(context).size.height * 0.23,
                          fit: BoxFit.fill,
                          width:
                          MediaQuery.of(context).size.width * 0.4),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          child: Text("가수 태연의 최애 산책로!", style: TextStyle(decoration: TextDecoration.underline, color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("사회적 거리두기에 모두 동참이..!", style: TextStyle(decoration: TextDecoration.underline, color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("연인과 걷고싶은 길 1위..", style: TextStyle(decoration: TextDecoration.underline, color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("혼자 나만의 시간이 필요할 때", style: TextStyle(decoration: TextDecoration.underline, color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                          child: Text("에너지가 넘치는 하루를..", style: TextStyle(decoration: TextDecoration.underline, color: Colors.brown)),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }
                      ),
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
