import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapoon/pageFolder/trailEditPage.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/iconCard.dart';
import 'package:sapoon/widget/imageAndIconShowWidget.dart';
import 'package:sapoon/widget/personRatingShowWidget.dart';

class TrailDetailPage extends StatefulWidget {
  final Activity activity;

  TrailDetailPage({this.activity});

  @override
  _TrailDetailPageState createState() => _TrailDetailPageState();
}

class _TrailDetailPageState extends State<TrailDetailPage> {

  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndIconShow(
                size: size,
                image: widget.activity.imgUrl,
              ),
              SizedBox(
                height: 20,
              ),
              PersonRatingShow(
                title: widget.activity.contents,
                country: widget.activity.writer,
                price: widget.activity.totalScore.toInt(),
                rating: widget.activity.rating.toInt(),
                startTime: widget.activity.startTimes[0],
                endTime: widget.activity.startTimes[1],
              ),
              SizedBox(height: 0.0),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                height: MediaQuery.of(context).size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/sun.svg",height: 23,width: 23,),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_2.svg",height: 23,width: 23,),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_3.svg",height: 23,width: 23,),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_4.svg",height: 18,width: 23,),
                    Text(':⭐ 2개'),
                  ],
                ),
              ),

              Row(
                children: <Widget>[
                  SizedBox(
                    width: size.width / 2,
                    height: 64,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                      color: Color(0xFF0C9869),
                      onPressed: () {},
                      child: Text(
                        "공유하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: size.width / 2,
                      height: 64,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrailEditPage(
                                   seq: widget.activity.dulleSeq,
                                  )));
                        },
                        child: Text(
                          "산책로 작성하기",
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
