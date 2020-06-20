import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '홈페이지',
              style: TextStyle(
                fontSize: 23.0,
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
                    Text(
                      'SAPOON',
                      style: TextStyle(
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '산책하기 정말 좋은 날',
                      style: TextStyle(
                          fontFamily: "NanumSquareRegular",
                          fontSize: 24.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(33.0),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/main');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.744,
                        height: MediaQuery.of(context).size.width * 0.125,
                        child: Center(
                          child: Text(
                            "로그인",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      ],
                    )

                  ],
                ),
              )),
        ),
    );
  }
}