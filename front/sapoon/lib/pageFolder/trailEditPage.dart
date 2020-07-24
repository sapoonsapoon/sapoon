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

  double iconValue1=0;
  double iconValue2=0;
  double iconValue3=0;
  double iconValue4=0;
  double iconValue5=0;
  double totalNumber=0;

  List<String> walkTimes = ['','','',''];

  String _now;
  Timer _everySecond;
  String textController;
  String walkInit;
  String walkEnd;
  String _nickName;

  File _image;
  PopupMenu menu;
  String walkTimeSign ='둘레길 산책한 시간을 입력해주세요.\n산책 예측은 다음 업데이트에 적용예정입니다!';

  final _textEditingController = TextEditingController();
  final _textEditingUserController=TextEditingController();
  String writerContents;


  @override
  void initState() {
    super.initState();
        _nickName = Hive.box('image').get('nickname');
  }

  void _updateLabels(String init, String end,String initServer, String endServer) {
    setState(() {
      Hive.box('image').put('walkInit',initServer);
      Hive.box('image').put('walkEnd',endServer);
      walkInit = initServer;
      walkEnd = endServer;
      walkTimes[2] = initServer;
      walkTimes[3] = endServer;
      walkTimeSign = walkTimes[0] +' ~ '+walkTimes[1];
    });
  }


  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingUserController.dispose();
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
                    height: MediaQuery.of(context).size.height * 0.17,
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
                          color: Colors.white,
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
                    TitlePriceRatingCommunity(
                      name: _nickName,
                      numOfReviews: 4,
                      rating: 3,
                      price: 3,
                      onRatingChanged: (value){
                        iconValue5 = value;
                        print(iconValue5);
                      },
                      isread: false,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(height: size.width * 0.03),
                    Center(
                      child: Text(
                        '그늘점수',
                        style: TextStyle(
                          height: 0.7,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Text(
                      '둘레길에 그늘이 많았나요?',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              borderColor: Colors.indigoAccent,
                              rating: 0,
                              isReadOnly: false,
                              onRated:  (value) {
                                iconValue1 =value;
                                print("rating value -> $value");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(height: size.width * 0.03),
                    Center(
                      child: Text(
                        '위치점수',
                        style: TextStyle(
                          height: 0.7,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Text(
                      '둘레길은 접근성이 괜찮았나요?',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '위치점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.deepOrangeAccent,
                              borderColor: Colors.orange,
                              rating: 0,
                              isReadOnly: false,
                              onRated:  (value) {
                                iconValue2 =value;
                                print("rating value -> $value");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Divider(
                      color: Colors.grey,
                    ),


                    SizedBox(height: size.width * 0.03),
                    Center(
                      child: Text(
                        '전망점수',
                        style: TextStyle(
                          height: 0.7,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Text(
                      '둘레길은 전망이 괜찮았나요?',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              borderColor: Colors.pinkAccent,
                              rating: 0,
                              isReadOnly: false,
                              onRated:  (value) {
                                iconValue3 =value;
                                print("rating value -> $value");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Divider(
                      color: Colors.grey,
                    ),


                    SizedBox(height: size.width * 0.03),
                    Center(
                      child: Text(
                        '관리점수',
                        style: TextStyle(
                          height: 0.7,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Text(
                      '둘레길은 관리가 잘 되었나요?',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '관리점수',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NanumSquareExtraBold',
                              ),
                            ),
                            SmoothStarRating(
                              color: Colors.blue,
                              borderColor: Colors.blueAccent,
                              rating: 0,
                              isReadOnly: false,
                              onRated:  (value) {
                                iconValue4 =value;
                                print("rating value -> $value");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                    Divider(
                      color: Colors.grey,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '걸었던 곳을 적어주세요',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold'
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                    SizedBox(height: size.height * 0.02),
                    TextField(
                      controller: _textEditingUserController,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NanumSquareExtraBold'
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Divider(
                      color: Colors.grey,
                    ),

                    SizedBox(height: size.height * 0.02),
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
                    TextField(
                      controller: _textEditingController,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'NanumSquareExtraBold'
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
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          walkTimeSign,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'NanumSquareExtraBold',
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),

                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                      width: size.width / 2,
                      height: 84,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {

                          print(_textEditingController.text);
                          createSignUp(
                            context,
                            _nickName,
                            _textEditingController.text,
                            iconValue1,
                            iconValue2,
                            iconValue3,
                            iconValue4,
                            iconValue5,
                            iconValue1*4+iconValue2*4+iconValue3*4
                                +iconValue4*4+iconValue5*4,
                            _textEditingUserController.text,
                            walkInit,
                            walkEnd,
                            widget.seq,
                          );
                        },
                        child: Text(
                          "저장하기",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  SizedBox(
                      width: size.width / 2,
                      height: 84,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                          ),
                        ),
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "작성취소",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),





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
      double score1,
      double score2,
      double score3,
      double score4,
      double starScore,
      double totalScore,
      String userDulleWrite,
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
      print(userDulleWrite);
      print(imageData);
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
        "userDulleWrite" : userDulleWrite,
        "startTime" : startTime,
        "endTime" : endTime,
        "imgFile" :await MultipartFile.fromFile(imageData, filename: 'sapoon.jpg'),
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

}



