import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sapoon/widget/showDialogTimeWidget.dart';
class PersonRatingEdit extends StatefulWidget {
  const PersonRatingEdit({
    Key key,
    this.title,
    this.country,
    this.price,
    this.rating,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  final String title, country, startTime, endTime;
  final int price, rating;
  @override
  _PersonRatingEditState createState() => _PersonRatingEditState();
}

class _PersonRatingEditState extends State<PersonRatingEdit> {
  final _controller = TextEditingController();
  List<String> walkTimes = ['','','',''];
  String walkTimeSign ='산책시간을 입력해주세요';
  Timer _everySecond;
  String _now;
  int recommandValue =0;
  int _totalNumber=0;
  int iconValue1=0;
  int iconValue2=0;
  int iconValue3=0;
  int iconValue4=0;
  int iconValue5=0;
  DateTime now = DateTime.now();


  @override
  void initState() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      Hive.box('image').put('textController',text);
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,);
    });

    _now = DateTime.now().second.toString();
    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
        recommandValue = Hive.box('image').get('recommend');
        _buildRatingStars(recommandValue);
        iconValue1 = Hive.box('image').get('sun');
        iconValue2 = Hive.box('image').get('health');
        iconValue3 = Hive.box('image').get('sight');
        iconValue4 = Hive.box('image').get('windy');
        iconValue5 = Hive.box('image').get('recommend');
        _totalNumber= 4*(iconValue1+iconValue2+iconValue3+iconValue4+iconValue5);
        Hive.box('image').put('totalNumber',_totalNumber);
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _everySecond.cancel();
    _controller.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height* 0.10,
                width: MediaQuery.of(context).size.width*0.6,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _controller,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: '한줄평을 적어주세요',
                          labelStyle: TextStyle(color: Colors.blue),
                        )
                    )
                  ],
                ),
              ),
              Spacer(),
              Text(
                _totalNumber.toString()+"점",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Color(0xFF0C9869)),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height* 0.03,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildRatingStars(recommandValue),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Text _buildRatingStars(int rating) {
    String stars = '';

    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text("추천 점수 : "+stars);
  }
}





