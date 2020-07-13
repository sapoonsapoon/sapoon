import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapoon/widget/imageAndIconEditWidget.dart';
import 'package:sapoon/widget/personRatingEditWidget.dart';

class TrailEditPage extends StatefulWidget {
  final List activity;

  TrailEditPage({this.activity});

  @override
  _TrailEditPageState createState() => _TrailEditPageState();
}

class _TrailEditPageState extends State<TrailEditPage> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List useValue = widget.activity;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndIconEdit(
                size: size,
                image: useValue[2],
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
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_2.svg",height: 30,width: 30,),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_3.svg",height: 30,width: 30,),
                    Text(':⭐ 2개'),
                    SvgPicture.asset("assets/icons/icon_4.svg",height: 20,width: 20,),
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
