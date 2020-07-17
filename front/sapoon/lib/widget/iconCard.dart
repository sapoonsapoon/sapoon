import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:popup_menu/popup_menu.dart';

class IconCard extends StatefulWidget {
  const IconCard({
    Key key,
    this.icon,
    this.sizeHW,
    this.iconName,
  }) : super(key: key);

  final String icon, iconName;
  final int sizeHW;

  @override
  _IconCardState createState() => _IconCardState();
}

class _IconCardState extends State<IconCard> with TickerProviderStateMixin {
  AnimationController _breathingController;
  var _breathe = 0.0;
  AnimationController _angleController;
  var _angle = 0.0;

  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  int scoreValue=0;
  var hiveSaveName='';
  Color colorsPick = Colors.blueAccent;
  bool isClick= false;
  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });
    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
    _breathingController.forward();

    _angleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _angleController.addListener(() {
      setState(() {
        _angle = _angleController.value * 45 / 360 * 2 * pi;
      });
    });

    menu = PopupMenu(items: [
      MenuItem(
          title: 'Mail',
          image: Icon(
            Icons.mail,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Power',
          image: Icon(
            Icons.power,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Setting',
          image: Icon(
            Icons.settings,
            color: Colors.white,
          )),
      MenuItem(
          title: 'PopupMenu',
          image: Icon(
            Icons.menu,
            color: Colors.white,
          ))
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
    isClick= true;
    if('${item.menuTitle}' == '별로에요'){
      scoreValue =1;
      colorsPick = Colors.redAccent;
    }else if('${item.menuTitle}' == '아쉬워요'){
      scoreValue =2;
      colorsPick = Colors.orangeAccent;
    }else if('${item.menuTitle}' == '평범했어요'){
      scoreValue =3;
      colorsPick = Colors.deepPurpleAccent;
    }else if('${item.menuTitle}' == '괜찮았어요'){
      scoreValue =4;
      colorsPick = Colors.green;
    }else if('${item.menuTitle}' == '매우 좋았어요'){
      scoreValue =5;
      colorsPick = Colors.blue;
    }
    print(widget.iconName);
    if(widget.iconName =='햇살 점수'){
      hiveSaveName = 'sun';
    }else if(widget.iconName =='체력 소모 정도'){
      hiveSaveName = 'health';
    }else if(widget.iconName =='전망 점수'){
      hiveSaveName = 'sight';
    }else if(widget.iconName =='바람 점수'){
      hiveSaveName = 'windy';
    }else if(widget.iconName =='추천 점수'){
      hiveSaveName = 'recommend';
    }
    print(hiveSaveName);
    Hive.box('image').put(hiveSaveName, scoreValue);
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        maxColumn: 3,
        items: [
          MenuItem(
              title: '별로에요',
              image: Icon(
                FontAwesomeIcons.angry,
                color: Colors.redAccent,
              )),
          MenuItem(
              title: '아쉬워요',
              image: Icon(
                FontAwesomeIcons.sadCry,
                color: Colors.orangeAccent,
              )),
          MenuItem(
              title: '평범했어요',
              image: Icon(
                FontAwesomeIcons.meh,
                color: Colors.deepPurpleAccent,
              )),
          MenuItem(
              title: '괜찮았어요',
              image: Icon(
                FontAwesomeIcons.laugh,
                color: Colors.green,
              )),
          MenuItem(
              title: '매우 좋았어요',
              image: Icon(
                FontAwesomeIcons.laughSquint,
                color: Colors.blue,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    Rect defaultPosition = PopupMenu.getWidgetGlobalRect(btnKey);
    Offset calulate = defaultPosition.topCenter;

    Rect position = Offset(calulate.dx - defaultPosition.width * 1,
            calulate.dy + defaultPosition.height / 7) &
        Size(defaultPosition.width, defaultPosition.height);
    menu.show(rect: position, widgetKey: btnKey);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: _buttonTap,
          child: MaterialButton(
            height: 45.0,
            key: btnKey,
            onPressed: maxColumn,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
              padding: EdgeInsets.all(18.0 / 2),
              height: widget.sizeHW + 0 * _breathe,
              width: widget.sizeHW + 0 * _breathe,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FD),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 22,
                    color: Color(0xFF0C9869).withOpacity(0.22),
                  ),
                  BoxShadow(
                    offset: Offset(-15, -15),
                    blurRadius: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              child: Transform.rotate(
                  angle: _angle, child: SvgPicture.asset(widget.icon, color: isClick ?  colorsPick : null,)),
            ),
          ),
        ),
        Text(
          widget.iconName,
          style: TextStyle(
              fontSize: 10,
              fontFamily: 'NanumSquareExtraBold',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _buttonTap() {
    if (_angleController.status == AnimationStatus.completed) {
      _angleController.reverse();
    } else if (_angleController.status == AnimationStatus.dismissed) {
      _angleController.forward();
    }
  }
}
