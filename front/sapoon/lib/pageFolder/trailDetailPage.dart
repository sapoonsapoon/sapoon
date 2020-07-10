import 'package:flutter/material.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:sapoon/widget/iconCardWidget.dart';
import 'package:sapoon/widget/personRatingWidget.dart';

class TrailDetailPage extends StatefulWidget {
  final Activity activity;

  TrailDetailPage({this.activity});

  @override
  _TrailDetailPageState createState() => _TrailDetailPageState();
}

class _TrailDetailPageState extends State<TrailDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndIcons(size: size, image: widget.activity.imageUrl,),
              SizedBox(
                height: 20,
              ),
              PersonRating(title: widget.activity.name, country: widget.activity.type, price: widget.activity.price),
              SizedBox(height: 10.0),
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
                      onPressed: () {},
                      child: Text("답글달기"),
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