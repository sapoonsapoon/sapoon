import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndIconShow(
                size: size,
                image: widget.activity.imageUrl,
              ),
              SizedBox(
                height: 20,
              ),
              PersonRatingShow(
                title: widget.activity.name,
                country: widget.activity.type,
                price: widget.activity.price,
                rating: widget.activity.rating,
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
                    SvgPicture.asset("assets/icons/icon_01.svg"),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_02.svg"),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_03.svg"),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_04.svg"),
                    Text(':⭐ 2개'),
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
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {},
                      child: Text("삭제하기"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
