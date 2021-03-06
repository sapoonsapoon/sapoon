
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initTime;
  int endTime;

  int inBedTime;
  int outBedTime;
  int days = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      initTime = _generateRandomTime();
      endTime = _generateRandomTime();
      inBedTime = initTime;
      outBedTime = endTime;
    });
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
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
                      Text('${_formatIntervalTime(inBedTime, outBedTime)}',
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
              _formatBedTime('산책 시작', inBedTime),
              _formatBedTime('산책 완료', outBedTime),
            ]),
            FlatButton(
              child: Text('저 장 하 기'),
              color: baseColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: _shuffle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatBedTime(String pre, int time) {
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
    return '$hours시 $minutes분';
  }

  String _formatIntervalTime(int init, int end) {
    var sleepTime = end > init ? end - init : 288 - init + end;
    var hours = sleepTime ~/ 12;
    var minutes = (sleepTime % 12) * 5;
    return '${hours}시 ${minutes}분';
  }

  int _generateRandomTime() => Random().nextInt(288);
}
