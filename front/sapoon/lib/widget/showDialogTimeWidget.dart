
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class ShowDialogTime extends StatefulWidget {
  @override
  _ShowDialogTimeState createState() => _ShowDialogTimeState();
}

class _ShowDialogTimeState extends State<ShowDialogTime> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initTime;
  int endTime;

  int inWalkTime;
  int outWalkTime;
  int days = 0;

  List<String> walkTime = ['',''];
  
  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      initTime = _generateRandomTime();
      endTime = _generateRandomTime();
      inWalkTime = initTime;
      outWalkTime = endTime;
    });
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inWalkTime = init;
      outWalkTime = end;
      days = laps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue,
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '오늘 산책 시간은 어땠나요?',
              style: TextStyle(color: Colors.white),
            ),
            DoubleCircularSlider(
              288,
              initTime,
              endTime,
              height: 260.0,
              width: 260.0,
              primarySectors: 6,
              secondarySectors: 24,
              baseColor: Color.fromRGBO(255, 255, 255, 0.1),
              selectionColor: baseColor,
              handlerColor: Colors.white,
              handlerOutterRadius: 12.0,
              onSelectionChange: _updateLabels,
              onSelectionEnd: (a, b, c) => print('onSelectionEnd $a $b $c'),
              sliderStrokeWidth: 12.0,
              child: Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text('${_formatIntervalTime(inWalkTime, outWalkTime)}',
                          style:
                          TextStyle(fontSize: 32.0, color: Colors.white)),
                      Text('${_formatDays(days)}',
                          style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.white,
                              fontStyle: FontStyle.italic)),
                    ],
                  )),
              shouldCountLaps: false,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _formatiInitWalkTime('산책 시작', inWalkTime),
              _formatEndWalkTime('산책 완료', outWalkTime),
            ]),
            FlatButton(
              child: Text('저 장 하 기'),
              color: baseColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: (){
                Navigator.pop(context,walkTime);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatiInitWalkTime(String pre, int time) {
    walkTime[0] = '${_formatSaveTime(time)}';
    return Column(
      children: [
        Text(pre, style: TextStyle(color: baseColor)),
        Text('', style: TextStyle(color: baseColor)),
        Text(
          '${_formatTime(time)}',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
  Widget _formatEndWalkTime(String pre, int time) {
    walkTime[1] = '${_formatSaveTime(time)}';
    return Column(
      children: [
        Text(pre, style: TextStyle(color: baseColor)),
        Text('', style: TextStyle(color: baseColor)),
        Text(
          '${_formatTime(time)}',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  String _formatDays(int days) {
    return days > 0 ? ' (+$days)' : '';
  }

  String _formatTime(int time) {
    if (time == 0 || time == null) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    String isAmPm;
    if(hours >= 12){
      isAmPm = 'PM';
      if(hours == 12){

      }else{
        hours-=12;
      }
    }
    else isAmPm = 'AM';

    return '$hours시 $minutes분 '+isAmPm;
  }

  String _formatSaveTime(int time) {
    if (time == 0 || time == null) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    String isAmPm;
    if(hours >= 12){
      isAmPm = 'PM';
      if(hours == 12){

      }else{
        hours-=12;
      }
    }

    else isAmPm = 'AM';

    return '$hours:$minutes '+isAmPm;
  }

  String _formatIntervalTime(int init, int end) {
    var sleepTime = end > init ? end - init : 288 - init + end;
    var hours = sleepTime ~/ 12;
    var minutes = (sleepTime % 12) * 5;

    return '${hours}시 ${minutes}분';
  }

  int _generateRandomTime() => Random().nextInt(288);
}
