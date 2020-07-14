import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/imageAndIconEditWidget.dart';
import 'package:sapoon/widget/personRatingEditWidget.dart';
import 'package:http/http.dart' as http;

class TrailEditPage extends StatefulWidget {
  final Activity activity;

  TrailEditPage({this.activity});

  @override
  _TrailEditPageState createState() => _TrailEditPageState();
}

class _TrailEditPageState extends State<TrailEditPage> {
  int iconValue1=0;
  int iconValue2=0;
  int iconValue3=0;
  int iconValue4=0;
  int iconValue5=0;
  String _now;
  Timer _everySecond;
  String textController;
  String walkInit;
  String walkEnd;

  @override
  void initState() {
    super.initState();
    Hive.box('image').put('setting',0);
    Hive.box('image').put('health',0);
    Hive.box('image').put('sight',0);
    Hive.box('image').put('company',0);
    Hive.box('image').put('textController','');
    Hive.box('image').put('walkInit','');
    Hive.box('image').put('walkEnd','');

    iconValue1 = Hive.box('image').get('setting');
    iconValue2 = Hive.box('image').get('health');
    iconValue3 = Hive.box('image').get('sight');
    iconValue4 = Hive.box('image').get('company');
    textController = Hive.box('image').get('textController');
    walkInit = Hive.box('image').get('walkInit');
    walkEnd = Hive.box('image').get('walkEnd');
    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
        iconValue1 = Hive.box('image').get('setting');
        iconValue2 = Hive.box('image').get('health');
        iconValue3 = Hive.box('image').get('sight');
        iconValue4 = Hive.box('image').get('company');
        textController = Hive.box('image').get('textController');
        walkInit = Hive.box('image').get('walkInit');
        walkEnd = Hive.box('image').get('walkEnd');
      });
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndIconEdit(
                size: size,
                image: '',
              ),
              SizedBox(
                height: 10,
              ),
              PersonRatingEdit(
                title: '입력해주세요!',
                country: '작성자 본인',
                price: 0,
                rating: 3,
                startTime: '20202',
                endTime: '20202',
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/sun.svg",height: 30,width: 30,),
                    Text(':⭐ '+iconValue1.toString()+'개'),
                    SvgPicture.asset("assets/icons/icon_2.svg",height: 30,width: 30,),
                    Text(':⭐ '+iconValue2.toString()+'개'),
                    SvgPicture.asset("assets/icons/icon_3.svg",height: 30,width: 30,),
                    Text(':⭐ '+iconValue3.toString()+'개'),
                    SvgPicture.asset("assets/icons/icon_4.svg",height: 20,width: 20,),
                    Text(':⭐ '+iconValue4.toString()+'개'),
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
                          topRight: Radius.circular(20),
                        ),
                      ),
                      color: Color(0xFF0C9869),
                      onPressed: () {
                        createSignUp(
                          context,
                         "백상우",
                          textController,
                          iconValue1.toDouble(),
                          iconValue2.toDouble(),
                          iconValue3.toDouble(),
                          iconValue4.toDouble(),
                          iconValue5.toDouble(),
                          walkInit,
                          walkEnd,
                          'a',
                        );
                      },
                      child: Text(
                        "저장하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: size.width / 2,
                      height: 84,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {},
                        child: Text(
                          "삭제하기",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
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
}


Future createSignUp(
    BuildContext context,
    String writer,
    String contents,
    double score1,
    double score2,
    double score3,
    double score4,
    double startScore,
    String startTime,
    String endTime,
    String imgUrl,
    ) async {
  print('시작합니다');
  String imageData = Hive.box('image').get('image');
  try {
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
      "starScore" : startScore,
      "startTime" : startTime,
      "endTime" : endTime,
      "imgFile" : await MultipartFile.fromFile(imageData, filename: 'sapoon.jpg'),
    });

    //[5] SEND TO SERVER
    var response = await dioRequest.post(
      dioRequest.options.baseUrl,
      data: formData,
    );
    final result = json.decode(response.toString());
    print(result);
  } catch (err) {
    print('ERROR  $err');
  }

}
