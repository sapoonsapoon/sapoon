import 'package:flutter/material.dart';

class Walks1 extends StatefulWidget {
  @override
  _Walks1State createState() => _Walks1State();
}

class _Walks1State extends State<Walks1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: 300,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, ),
                    ),
                    Text(
                      '둘레길 : 석촌호수',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareRegular",
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04, ),
              ),
              Text(

                '    둘레길 정보 : 석촌호수공원(石村湖水公園)은 서울특별시\n                         송파구 잠실동에 있는 공원이다.',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.06, ),
              ),
              Text(

                '    둘레길 면적 : 285,757m2',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02, ),
              ),
              Text(

                '    둘레길 출발 : 잠실환승센터 1번 출구',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02, ),
              ),
              Text(

                '    둘레길 종료 : 잠실환승센터 2번 출구',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03, ),
              ),
              Text(

                '    둘레길 경로 : 잠실환승센터 1번 출구 > 석촌호수(동호)\n                        > 송파나루길 > 잠실환승센터 2번 출구',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                width: 300,
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03, ),
              ),
              Text(
                '    지도',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "NanumSquareRegular",
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Image.asset('lib/assets/images/walk1.png'),

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
