import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:sapoon/components/title_price_rating.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/imageAndIconEditWidget.dart';
import 'package:sapoon/widget/personRatingEditWidget.dart';
import 'package:http/http.dart' as http;
import 'package:sapoon/widget/showDialogTimeWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TrailEditPage extends StatefulWidget {
  final int seq;

  TrailEditPage({this.seq});

  @override
  _TrailEditPageState createState() => _TrailEditPageState();
}

class _TrailEditPageState extends State<TrailEditPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  TextEditingController _whereGoTextController = TextEditingController();

  int iconValue1=0;
  int iconValue2=0;
  int iconValue3=0;
  int iconValue4=0;
  int iconValue5=0;
  int totalNumber=0;

  List<String> walkTimes = ['','','',''];

  String _now;
  Timer _everySecond;
  String textController;
  String walkInit;
  String walkEnd;
  String _nickName;

  File _image;
  PopupMenu menu;
  String walkTimeSign ='산책시간을 입력해주세요';

  @override
  void initState() {
    super.initState();
        _nickName = Hive.box('image').get('nickname');
  }

  void _updateLabels(String init, String end,String initServer, String endServer) {
    setState(() {
      Hive.box('image').put('walkInit',initServer);
      Hive.box('image').put('walkEnd',endServer);
      walkTimes[0] = init;
      walkTimes[1] = end;
      walkTimes[2] = initServer;
      walkTimes[3] = endServer;
      walkTimeSign = walkTimes[0] +' ~ '+walkTimes[1];
    });
  }


  @override
  void dispose() {
    _everySecond.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              '커뮤니티 상세 작성 페이지',
              style: TextStyle(
                fontFamily: "NanumSquareExtraBold",
                fontSize: 21.0,
              ),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child:
                    (_image != null) ? Image.file(_image, width: MediaQuery.of(context).size.width * 0.75, height: MediaQuery.of(context).size.height * 0.13,) : Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.photo, size: 100, color: Colors.white,),
                            Text('사진을 등록해주세요',style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'NanumSquareExtraBold',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold ),)
                          ],
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 60,
                          color: Color(0xFF0C9869).withOpacity(0.29),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("겔러리"),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                      ),
                      RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text("카메라"),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: <Widget>[


                    shopeName(name: '어디를 산책하셨나요?'),
                    TitlePriceRatingCommunity(
                      name: _nickName,
                      numOfReviews: 4,
                      rating: 3,
                      price: 3,
                      isread: false,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '그늘점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.lightGreen,
                              borderColor: Colors.greenAccent,
                              rating: 0,
                              isReadOnly: true,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '위치점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.deepOrangeAccent,
                              borderColor: Colors.greenAccent,
                              rating: 0,
                              isReadOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '전망점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.yellow,
                              borderColor: Colors.greenAccent,
                              rating: 0,
                              isReadOnly: true,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '관리점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.blue,
                              borderColor: Colors.greenAccent,
                              rating: 0,
                              isReadOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Center(
                      child: Text(
                        '작성자 한줄평',
                        style: TextStyle(
                          height: 0.5,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      '',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Center(
                      child: Text(
                        '산책 시간',
                        style: TextStyle(
                          height: 0.5,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),

                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (_) {
                        return ShowDialogTime();
                      }).then((value){
                    walkTimes = value;
                    print(walkTimes);
                    _updateLabels(walkTimes[0],walkTimes[1],walkTimes[2],walkTimes[3]);
                  }
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  width: 150.0,
                  alignment: Alignment.centerRight,
                  child: Text(
                    walkTimeSign,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
//              SizedBox(
//                height: 10,
//              ),
//              PersonRatingEdit(
//                title: '입력해주세요!',
//                country: '작성자 본인',
//                price: 0,
//                rating: 0,
//                startTime: '20202',
//                endTime: '20202',
//              ),
//              Container(
//                margin: EdgeInsets.only(left: 10, right: 10),
//                height: MediaQuery.of(context).size.height * 0.12,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    SvgPicture.asset("assets/icons/sun.svg",height: 23,width: 23,),
//                    Text(':⭐ '+iconValue1.toString()+'개'),
//                    SvgPicture.asset("assets/icons/icon_2.svg",height: 23,width: 23),
//                    Text(':⭐ '+iconValue2.toString()+'개'),
//                    SvgPicture.asset("assets/icons/icon_3.svg",height: 23,width: 23),
//                    Text(':⭐ '+iconValue3.toString()+'개'),
//                    SvgPicture.asset("assets/icons/icon_4.svg",height: 18,width: 14),
//                    Text(':⭐ '+iconValue4.toString()+'개'),
//                  ],
//                ),
//              ),
//              Row(
//                children: <Widget>[
//                  SizedBox(
//                    width: size.width / 2,
//                    height: 84,
//                    child: FlatButton(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.only(
//                          topRight: Radius.circular(20),
//                        ),
//                      ),
//                      color: Color(0xFF0C9869),
//                      onPressed: () {
//                        createSignUp(
//                          context,
//                          _nickName,
//                          textController,
//                          iconValue1,
//                          iconValue2,
//                          iconValue3,
//                          iconValue4,
//                          iconValue5,
//                          totalNumber,
//                          walkInit,
//                          walkEnd,
//                          widget.seq,
//                        );
//                      },
//                      child: Text(
//                        "저장하기",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16,
//                        ),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                      width: size.width / 2,
//                      height: 84,
//                      child: FlatButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                          ),
//                        ),
//                        color: Colors.white,
//                        onPressed: () {
//                          Navigator.pop(context);
//                        },
//                        child: Text(
//                          "삭제하기",
//                          style: TextStyle(
//                            color: Colors.black54,
//                            fontSize: 16,
//                          ),
//                        ),
//                      )),
//                ],
//              ),
            ],
          ),
        ),
      ),
    );
  }
  Future createSignUp(
      BuildContext context,
      String writer,
      String contents,
      int score1,
      int score2,
      int score3,
      int score4,
      int starScore,
      int totalScore,
      String startTime,
      String endTime,
      int seq,
      ) async {
    print('시작합니다');
    String imageData = Hive.box('image').get('image');
    try {
      print(writer);
      print(contents);
      print(score1);
      print(score2);
      print(score3);
      print(score4);
      print(starScore);
      print(totalScore);
      print(startTime);
      print(endTime);
      print(seq);
      String walkInit = Hive.box('image').get('walkInit');
      String walkEnd = Hive.box('image').get('walkEnd');
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = 'http://34.80.151.71/sapoon/community';

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData =
      new dio.FormData.fromMap({
        "writer" : writer,
        "contents" :contents,
        "score1" : score1,
        "score2" : score2,
        "score3" : score3,
        "score4" : score4,
        "starScore" : starScore,
        "totalScore" : totalScore,
        "startTime" : walkInit,
        "endTime" : walkEnd,
        "imgFile" : await MultipartFile.fromFile(imageData, filename: 'sapoon.jpg'),
        "dulleSeq" : seq,
      });


      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        dioRequest.options.baseUrl,
        data: formData,
      );
      print(writer);
      print(response.data);
      print(response.headers);

      if( response.data['result'] == 'success'){
        Navigator.pop(context);
      }
    } catch (err) {
      showInSnackBar('값을 전부 입력해주세요!');
      print('ERROR  $err');

    }
  }

  void getImage(ImageSource source) async {
    print("getImageFromGallery");
    var image = await ImagePicker().getImage(source: source);

    setState(() {
      _image = File(image.path);
      Hive.box('image').put('image', image.path);
    });
  }

  Row shopeName({String name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.green,
        ),
        SizedBox(width: 10),
        
      ],
    );
  }
}



