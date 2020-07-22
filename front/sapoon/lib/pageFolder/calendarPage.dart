//캘린더 스크린
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  Map<DateTime, List<dynamic>> _events;
  List _calendarComponent;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  TextEditingController _eventController1; //제목 텍스트
  TextEditingController _eventController2; //서브 타이틀 텍스트

  SharedPreferences prefs;

  Map<DateTime, List> _holidays = {};

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {};

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _eventController1 = TextEditingController();
    _eventController2 = TextEditingController();
    _animationController.forward();
    initPrefs();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    _eventController1.dispose();
    _eventController2.dispose();
    super.dispose();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        title: Text(' Sapoon 달력', style: TextStyle(
        fontFamily: "NanumSquareExtraBold",
        fontSize: 21.0),)
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.red[600]),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontSize: 18),
        leftChevronMargin: EdgeInsets.all(10),
        rightChevronMargin: EdgeInsets.all(10),
        leftChevronPadding: EdgeInsets.all(0),
        rightChevronPadding: EdgeInsets.all(0),
        decoration: BoxDecoration(color: Colors.green,
            borderRadius:  BorderRadius.circular(30)),
        centerHeaderTitle: true,
        formatButtonVisible: false,
        headerMargin: EdgeInsets.only(top:20,bottom: 30)
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.green[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: 0,
                top: 0,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.green[500]
            : _calendarController.isToday(date)
                ? Colors.green[300]
                : Colors.green[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.alarm,
      size: 40.0,
      color: Colors.green,
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList(BuildContext context) {
    return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          return Dismissible(
              background: stackBehindDismiss(),
              key: ObjectKey(_selectedEvents[index]),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(_selectedEvents[index][1])),
                title: Text(_selectedEvents[index][0]),
                subtitle: Text(_selectedEvents[index][2]),
              ),
              onDismissed: (direction) {
                var item = _selectedEvents.elementAt(index);
                //To delete
                deleteItem(index);
                //To show a snackbar with the UNDO button

                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("산책 예약을 지웠어요!"),
                    action: SnackBarAction(
                        label: "복원합니다.",
                        textColor: Colors.blue,
                        disabledTextColor: Colors.blue,
                        onPressed: () {
                          //To undo deletion
                          undoDeletion(index, item);
                        })));
              });
        });
  }

  void deleteItem(index) {
    /*
  By implementing this method, it ensures that upon being dismissed from our widget tree,
  the item is removed from our list of items and our list is updated, hence
  preventing the "Dismissed widget still in widget tree error" when we reload.
  */
    setState(() {
      _selectedEvents.removeAt(index);
    });
  }

  void undoDeletion(index, item) {
    /*
  This method accepts the parameters index and item and re-inserts the {item} at
  index {index}
  */
    setState(() {
      _selectedEvents.insert(index, item);
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => SafeArea(
              child: AlertDialog(
                content: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _eventController1,
                          decoration: InputDecoration.collapsed(
                            hintText: "예약할 산책 코스를 적어주세요!",
                          ),
                        ),
                        Image.asset(
                          'lib/assets/images/verybad.png',
                          height: MediaQuery.of(context).size.width * (150.0 / 375),
                        ),
                        Text(
                          '앗 산책을 미리 계획해둘까요?',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0XFFFF6E6E),
                          ),
                        ),
                        TextField(
                          controller: _eventController2,
                          decoration: InputDecoration.collapsed(
                              hintText: "내용을 적어주세요!"),
                        )
                      ]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Save"),
                    onPressed: () {
                      if (_eventController1.text.isEmpty) return;
                      setState(() {
                        if (_events[_calendarController.selectedDay] != null) {
                          _events[_calendarController.selectedDay]
                              .add(_calendarComponent = [
                            _eventController1.text,
                            'lib/assets/images/calendar_event.jpg',
                            _eventController2.text
                          ]);
                        } else {
                          _events[_calendarController.selectedDay] = [
                            _calendarComponent = [
                              _eventController1.text,
                              'lib/assets/images/calendar_event.jpg',
                              _eventController2.text
                            ],
                          ];
                        }
                        prefs.setString(
                            "events", json.encode(encodeMap(_events)));
                        _eventController2.clear();
                        _eventController1.clear();
                        Navigator.pop(context);
                      });
                    },
                  )
                ],
              ),
            ));
  }
}
