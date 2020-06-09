import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'HomePage.dart';
import 'package:geolocator/geolocator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pwControllerCf = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  var geolocator = Geolocator();
  var locationOptions =
  LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  String show_log='';

  void _incrementCounter(String value) {
    setState(() {
      show_log =value;
      print(show_log);
    });
  }

  @override
  Widget build(BuildContext context) {

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
          ', ' +
          position.longitude.toString());
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('회원가입 화면', textAlign: TextAlign.right,),

        ),
        body: Builder(builder: (BuildContext context) {
      return SafeArea(
        child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'SAPOON 회원가입',
                    style: TextStyle(
                        fontFamily: "NanumSquareExtraBold",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.744,
                    height: MediaQuery.of(context).size.width * 0.100,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                      controller: _idController,
                      decoration: getTextFieldDecor('아이디'),
                      validator: (String value) {
                        //pw input 조건
                        if (value.isEmpty) {
                          return "빈칸은 허용할 수 없어요:)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.744,
                    height: MediaQuery.of(context).size.width * 0.100,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                      obscureText: true,
                      controller: _pwController,
                      decoration: getTextFieldDecor('Password'),
                      validator: (String value) {
                        //pw input 조건
                        if (value.isEmpty) {
                          return "빈칸은 허용할 수 없어요:)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.744,
                    height: MediaQuery.of(context).size.width * 0.100,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                      controller: _pwControllerCf,
                      decoration: getTextFieldDecor('비밀번호 확인'),
                      validator: (String value) {
                        //pw input 조건
                        if (value.isEmpty) {
                          return "인빈칸은 허용할 수 없어요:)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.372,
                        height: MediaQuery.of(context).size.width * 0.100,
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.black45, fontWeight: FontWeight.bold),
                          controller: _nameController,
                          decoration: getTextFieldDecor('이름'),
                          validator: (String value) {
                            //pw input 조건
                            if (value.isEmpty) {
                              return "인빈칸은 허용할 수 없어요:)";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.372,
                        height: MediaQuery.of(context).size.width * 0.100,
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.black45, fontWeight: FontWeight.bold),
                          controller: _sexController,
                          decoration: getTextFieldDecor('성별'),
                          validator: (String value) {
                            //pw input 조건
                            if (value.isEmpty) {
                              return "인빈칸은 허용할 수 없어요:)";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onChanged: (date) {

                        },
                        onConfirm: (date) {
                          print('완료 $date');
                          String sss = DateFormat("yyyy-MM-dd").format(date);
                          _incrementCounter(sss);
                          print(sss);
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.ko,

                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.744,
                      height: MediaQuery.of(context).size.width * 0.100,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0XFFA3C0F1),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            size: 10,
                            color: Colors.green,
                          ),
                          Text(
                            show_log,
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.744,
                    height: MediaQuery.of(context).size.width * 0.100,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                      controller: _nicknameController,
                      decoration: getTextFieldDecor('닉네임'),
                      validator: (String value) {
                        //pw input 조건
                        if (value.isEmpty) {
                          return "빈칸은 허용할 수 없어요:)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.744,
                    height: MediaQuery.of(context).size.width * 0.100,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                      controller: _emailController,
                      decoration: getTextFieldDecor('이메일'),
                      validator: (String value) {
                        //pw input 조건
                        if (value.isEmpty) {
                          return "빈칸은 허용할 수 없어요:)";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  InkWell(
                    onTap: () {
                      print('눌렀어요ㅃ');
                      final snackbar = SnackBar(content: Text('계정이 없습니다.'));
                      Scaffold.of(context).showSnackBar(snackbar);
                      createAlbum(context,
                         _idController.text,
                       _pwController.text,
                       _nameController.text,
                       _sexController.text,
                       _nicknameController.text,
                     _emailController.text,
                      show_log,
                        show_log,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.744,
                      height: MediaQuery.of(context).size.width * 0.125,
                      child: Center(
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
      );
    }));
  }
}

InputDecoration getTextFieldDecor(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black45),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA3C0F1),
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA3C0F1),
        width: 1,
      ),
    ),
    fillColor: Colors.transparent,
    filled: true,
  );
}



Future createAlbum(BuildContext context,
    String id,
    String password,
    String name,
    String gender,
    String birthday,
    String email,
    String nickname,
    String registPath) async {
  final http.Response response = await http.post(
    'http://35.194.192.57/sapoon/member/regist',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '513',
      'password':"$password",
      'name':'$name',
      'gender':'1',
      'birthday':'$birthday',
      'email': 'ss',
      'nickname': 'ss',
      'registPath': "1"
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('성공적이에요!');

  } else {
    print(name);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}

