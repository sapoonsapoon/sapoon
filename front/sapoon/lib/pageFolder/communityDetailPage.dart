import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sapoon/components/title_price_rating.dart';
import 'package:sapoon/pageFolder/trailEditPage.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/iconCard.dart';
import 'package:sapoon/widget/imageAndIconShowWidget.dart';
import 'package:sapoon/widget/personRatingShowWidget.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TrailDetailPage extends StatefulWidget {
  final Activity activity;

  TrailDetailPage({this.activity});

  @override
  _TrailDetailPageState createState() => _TrailDetailPageState();
}

//http://34.80.151.71/sapoon/promenade/dullegil/get/20
Future<Post> detailPost(int seq) async {
  final http.Response response = await http.get(
      Uri.encodeFull('http://34.80.151.71/sapoon/promenade/dullegil/get/' +
          seq.toString()),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return makePost(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception();
  }
}

class _TrailDetailPageState extends State<TrailDetailPage> {
  double avgScore = Hive.box('image').get('avgScore');
  double totalCount = Hive.box('image').get('totalCount');
  String dulleSeq = Hive.box('image').get('dulleSeq');

  Future<totalPointAvg> totalAvgPoint;

  Future<Post> postSearch;
  Post getValue;

  int initTime;
  int endTime;

  int inWalkTime;
  int outWalkTime;
  int days = 0;
  DateTime now = DateTime.now();
  String formattedDate = '';
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);
  List<String> walkTime = ['', '', '', ''];

  bool isLike=false;
  bool isThumbs=false;
  IconData likeiconNClick = FontAwesomeIcons.heart;
  IconData likeiconClick = FontAwesomeIcons.solidHeart;
  IconData likeiconClickSet = FontAwesomeIcons.heart;

  IconData isThumbiconNClick = FontAwesomeIcons.shareAlt;
  IconData isThumbiconClick = FontAwesomeIcons.shareAlt;
  IconData isThumbiconClickSet = FontAwesomeIcons.shareAlt;


  Future<void> share() async {
    await FlutterShare.share(
        title: 'Sapoon',
        text: 'Sapoon 전송테스트입니다.',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.ds.sapoon',
        chooserTitle: 'Sapoon Sapoon'
    );
  }

  Future<void> shareFile() async {
    await FlutterShare.shareFile(
      title: 'Sapoon입니',
      text: '전송 테스트 입니다.',

    );
  }


  @override
  void initState() {
    super.initState();
    postSearch = detailPost(widget.activity.dulleSeq);
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      inWalkTime = initTime;
      outWalkTime = endTime;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.24,
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            Text(
              '커뮤니티 상세 페이지',
              style: TextStyle(
                fontFamily: "NanumSquareExtraBold",
                fontSize: 21.0,
              ),
            ),
            GestureDetector(
                onTap: (){
                  if(likeiconClickSet == likeiconNClick)
                    {
                      setState(() {
                        likeiconClickSet = likeiconClick;
                      });
                    }
                  else{
                    setState(() {
                      likeiconClickSet = likeiconNClick;
                    });
                  }

                },
               child: Icon( likeiconClickSet, color: Colors.red,)),
            GestureDetector(
                onTap: (){
                  share();
                },
                child: Icon(isThumbiconClickSet, color: Colors.blue,)),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.25,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                  ),
                  items: [widget.activity.imgUrl].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return ImageDetailDulleHome('$i');
                              }));
                            },
                            child: CachedNetworkImage(
                              imageUrl: '$i',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                value: downloadProgress.progress,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blueAccent),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
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
                      shopeName(name: widget.activity.userDulleWrite),
                      TitlePriceRatingCommunity(
                        name: widget.activity.writer,
                        numOfReviews: widget.activity.score4.toInt(),
                        rating: widget.activity.totalScore.toDouble(),
                        price: widget.activity.score2.toDouble(),
                        isread: true,
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
                                rating: widget.activity.score2.toDouble(),
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
                                rating: widget.activity.score2.toDouble(),
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
                                rating: widget.activity.score2.toDouble(),
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
                                rating: widget.activity.score2.toDouble(),
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
                        widget.activity.contents,
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

                      Text(widget.activity.startTimes[0] + " ~ "+ widget.activity.startTimes[1]),

                    ],
                  ),
                ),

//                FutureBuilder(
//                  future: postSearch,
//                  // ignore: missing_return
//                  builder: (context, snapshot) {
//                    getValue = snapshot.data;
//                    if (snapshot.hasData == false) {
//                      Center(
//                        child: Container(
//                            child: CircularProgressIndicator()),
//                      );
//                    }
//                    else if(snapshot.hasError){
//                      Center(
//                        child: Container(
//                            child: CircularProgressIndicator()),
//                      );
//                    }
//                    else {
//                      return Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          CarouselSlider(
//                            options: CarouselOptions(
//                              height: MediaQuery.of(context).size.height * 0.25,
//                              autoPlay: false,
//                              enlargeCenterPage: true,
//                              viewportFraction: 0.9,
//                              aspectRatio: 2.0,
//                            ),
//                            items: [
//                              getValue.trailUrl,
//                              getValue.trailUrl2,
//                              getValue.trailUrl3,
//                              getValue.trailUrl4
//                            ].map((i) {
//                              return Builder(
//                                builder: (BuildContext context) {
//                                  return Container(
//                                    width: MediaQuery.of(context).size.width,
//                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                    child: GestureDetector(
//                                      onTap: () {
//                                        Navigator.push(context, MaterialPageRoute<void>(
//                                            builder: (BuildContext context) {
//                                              return ImageDetailDulleHome('$i');
//                                            }));
//                                      },
//                                      child: Hero(
//                                        tag: '$i',
//                                        child: CachedNetworkImage(
//                                          imageUrl: '$i',
//                                          progressIndicatorBuilder:
//                                              (context, url, downloadProgress) =>
//                                              CircularProgressIndicator(
//                                                value: downloadProgress.progress,
//                                                valueColor: AlwaysStoppedAnimation<Color>(
//                                                    Colors.blueAccent),
//                                              ),
//                                          errorWidget: (context, url, error) =>
//                                              Icon(Icons.error),
//                                          fit: BoxFit.cover,
//                                          width: MediaQuery.of(context).size.width,
//                                        ),
//                                      ),
//                                    ),
//                                  );
//                                },
//                              );
//                            }).toList(),
//                          ),
//                          Container(
//                            padding: EdgeInsets.all(20),
//                            width: double.infinity,
//                            decoration: BoxDecoration(
//                              color: Colors.white,
//                              borderRadius: BorderRadius.only(
//                                topLeft: Radius.circular(30),
//                                topRight: Radius.circular(30),
//                              ),
//                            ),
//                            child: Column(
//                              children: <Widget>[
//                                shopeName(name: getValue.trailName),
//                                TitlePriceRating(
//                                  name: getValue.trailShortName,
//                                  numOfReviews: totalCount,
//                                  rating: avgScore,
//                                  price: getValue.trailDistanceDetail,
//                                  onRatingChanged: (value) {},
//                                ),
//                                Center(
//                                  child: Text(
//                                    '둘레길 설명',
//                                    style: TextStyle(
//                                      height: 0.5,
//                                      color: Colors.green,
//                                      fontFamily: 'NanumSquareExtraBold',
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(height: size.height * 0.01),
//                                Text(
//                                  getValue.trailDescription,
//                                  style: TextStyle(
//                                    height: 1.5,
//                                  ),
//                                ),
//                                SizedBox(height: size.height * 0.01),
//                                SizedBox(height: size.height * 0.01),
//                                SizedBox(height: size.height * 0.01),
//                                Center(
//                                  child: Text(
//                                    '둘레길 경로',
//                                    style: TextStyle(
//                                      height: 0.5,
//                                      color: Colors.green,
//                                      fontFamily: 'NanumSquareExtraBold',
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(height: size.height * 0.01),
//                                Text(
//                                  getValue.trailCourseDescription,
//                                  style: TextStyle(
//                                    height: 1.5,
//                                  ),
//                                ),
//                                SizedBox(height: size.height * 0.01),
//                                SizedBox(height: size.height * 0.01),
//                                SizedBox(height: size.height * 0.01),
//                                Center(
//                                  child: Text(
//                                    '둘레길 휴게정보 및 음수대',
//                                    style: TextStyle(
//                                      height: 0.5,
//                                      color: Colors.green,
//                                      fontFamily: 'NanumSquareExtraBold',
//                                    ),
//                                  ),
//                                ),
//                                SizedBox(height: size.height * 0.01),
//                                Text(
//                                  getValue.trailCafeteriaInfo +
//                                      '/' +
//                                      getValue.trailDrinkingWaterInfo,
//                                  style: TextStyle(
//                                    height: 1.5,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          GestureDetector(
//                            onTap: () {
//                              Navigator.push(context,
//                                  MaterialPageRoute<void>(builder: (BuildContext context) {
//                                    return ImageDetailDulleHome(
//                                        getValue.trailKakaoMapImgUrl);
//                                  }));
//                            },
//                            child: Hero(
//                              tag: getValue.trailKakaoMapImgUrl,
//                              child: CachedNetworkImage(
//                                imageUrl: getValue.trailKakaoMapImgUrl,
//                                progressIndicatorBuilder:
//                                    (context, url, downloadProgress) =>
//                                    CircularProgressIndicator(
//                                      value: downloadProgress.progress,
//                                      valueColor:
//                                      AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//                                    ),
//                                errorWidget: (context, url, error) => Icon(Icons.error),
//                                fit: BoxFit.cover,
//                                width: MediaQuery.of(context).size.width,
//                              ),
//                            ),
//                          ),
//
//                          ImageAndIconShow(
//                            size: size,
//                            image: widget.activity.imgUrl,
//                          ),
//                          SizedBox(
//                            height: 20,
//                          ),
//                          PersonRatingShow(
//                            title: widget.activity.contents,
//                            country: widget.activity.writer,
//                            price: widget.activity.totalScore.toInt(),
//                            rating: widget.activity.rating.toInt(),
//                            startTime: widget.activity.startTimes[0],
//                            endTime: widget.activity.startTimes[1],
//                          ),
//                          SizedBox(height: 0.0),
//                          Container(
//                            margin: EdgeInsets.only(left: 10, right: 10),
//                            height: MediaQuery.of(context).size.height * 0.12,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                SvgPicture.asset(
//                                  "assets/icons/sun.svg",
//                                  height: 23,
//                                  width: 23,
//                                ),
//                                Text(':⭐ 2개'),
//                                SvgPicture.asset(
//                                  "assets/icons/icon_2.svg",
//                                  height: 23,
//                                  width: 23,
//                                ),
//                                Text(':⭐ 2개'),
//                                SvgPicture.asset(
//                                  "assets/icons/icon_3.svg",
//                                  height: 23,
//                                  width: 23,
//                                ),
//                                Text(':⭐ 2개'),
//                                SvgPicture.asset(
//                                  "assets/icons/icon_4.svg",
//                                  height: 18,
//                                  width: 23,
//                                ),
//                                Text(':⭐ 2개'),
//                              ],
//                            ),
//                          ),
//                          Row(
//                            children: <Widget>[
//                              SizedBox(
//                                width: size.width / 2,
//                                height: 64,
//                                child: FlatButton(
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.only(
//                                      topRight: Radius.circular(20),
//                                    ),
//                                  ),
//                                  color: Color(0xFF0C9869),
//                                  onPressed: () {},
//                                  child: Text(
//                                    "공유하기",
//                                    style: TextStyle(
//                                      color: Colors.white,
//                                      fontSize: 16,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              SizedBox(
//                                  width: size.width / 2,
//                                  height: 64,
//                                  child: FlatButton(
//                                    shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.only(
//                                        topLeft: Radius.circular(20),
//                                      ),
//                                    ),
//                                    color: Colors.white,
//                                    onPressed: () {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => TrailEditPage(
//                                                seq: widget.activity.dulleSeq,
//                                              )));
//                                    },
//                                    child: Text(
//                                      "산책로 작성하기",
//                                      style: TextStyle(
//                                        color: Colors.black54,
//                                        fontSize: 16,
//                                      ),
//                                    ),
//                                  )),
//                            ],
//                          ),
//                        ],
//                      );
//                    }
//                  },
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row shopeName({String name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.green,
        ),
        SizedBox(width: 10),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

}

class ImageDetailDulleHome extends StatelessWidget {
  final String imageUrl;

  ImageDetailDulleHome(this.imageUrl); // 생성자를 통해 imageUrl 을 전달받음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Hero(
              tag: imageUrl,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
