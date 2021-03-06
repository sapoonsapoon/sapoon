import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/components/order_button.dart';
import 'package:sapoon/components/title_price_rating.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:http/http.dart' as http;

class DulleTrailDetailPage extends StatefulWidget {
  final Post posts;

  DulleTrailDetailPage({this.posts});

  @override
  _DulleTrailDetailPageState createState() => _DulleTrailDetailPageState();
}

class _DulleTrailDetailPageState extends State<DulleTrailDetailPage> {
  Future<totalPointAvg> getTotalPointAvg() async {
    final http.Response response = await http.get(
        Uri.encodeFull('http://34.80.151.71/sapoon/community/score/' +
            widget.posts.seq.toString()),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return makeTotalPointAvgList(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception();
    }
  }

  double avgScore = Hive.box('image').get('avgScore');
  double totalCount = Hive.box('image').get('totalCount');
  String dulleSeq = Hive.box('image').get('dulleSeq');

  Future<totalPointAvg> totalAvgPoint;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAvgPoint = getTotalPointAvg();
  }

  @override
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
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 2,
                ),
                items: [
                  widget.posts.trailUrl,
                  widget.posts.trailUrl2,
                  widget.posts.trailUrl3,
                  widget.posts.trailUrl4
                ].map((i) {
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
                          child: Hero(
                            tag: '$i',
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
                    shopeName(name: widget.posts.trailName),
                    TitlePriceRating(
                      name: widget.posts.trailShortName,
                      numOfReviews: totalCount.toInt(),
                      rating: avgScore,
                      price: widget.posts.trailDistanceDetail,
                      onRatingChanged: (value) {},
                      isread: true,
                    ),
                    Center(
                      child: Text(
                        '둘레길 설명',
                        style: TextStyle(
                          height: 0.5,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      widget.posts.trailDescription,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(height: size.height * 0.01),
                    Center(
                      child: Text(
                        '둘레길 경로',
                        style: TextStyle(
                          height: 0.5,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      widget.posts.trailCourseDescription,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(height: size.height * 0.01),
                    Center(
                      child: Text(
                        '둘레길 휴게정보 및 음수대',
                        style: TextStyle(
                          height: 0.5,
                          color: Colors.green,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      widget.posts.trailCafeteriaInfo +
                          '/' +
                          widget.posts.trailDrinkingWaterInfo,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return ImageDetailDulleHome(
                        widget.posts.trailKakaoMapImgUrl);
                  }));
                },
                child: Hero(
                  tag: widget.posts.trailKakaoMapImgUrl,
                  child: CachedNetworkImage(
                    imageUrl: widget.posts.trailKakaoMapImgUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ],
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
