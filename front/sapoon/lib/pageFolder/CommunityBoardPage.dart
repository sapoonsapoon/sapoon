import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommunityBoardPage extends StatefulWidget {
  @override
  _CommunityBoardPageState createState() => _CommunityBoardPageState();
}

class _CommunityBoardPageState extends State<CommunityBoardPage> {


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
              '커뮤니티',
              style: TextStyle(
                fontFamily: "NanumSquareExtraBold",
                fontSize: 21.0,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
            child: Column(
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
                        '여기 정말 예쁘죠?',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "NanumSquareRegular",
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                  width: 300,
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
                      child: CachedNetworkImage(
                        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRo93aJCVkzf3LytZ4x7npQ6c_yLz9hTl7BDg&usqp=CAU",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          height:
                          MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.fill,
                          width:
                          MediaQuery.of(context).size.width * 0.42
                      ),

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

    );
  }
}
