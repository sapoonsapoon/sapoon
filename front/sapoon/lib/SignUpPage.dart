import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    String startDate = '2020/02/12';
    String _endDate = '';

    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/images/walktowalk.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
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
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.744,
                height: MediaQuery.of(context).size.width * 0.100,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                    onChanged: (date) {},
                    onConfirm: (date) {
                      print('완료 $date');
                      setState(() {
                        startDate = date.toString();
                        print(startDate);
                      });
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
                        '$startDate',
                        style: TextStyle(
                          color: Colors.white,
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
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                  Future<Album> createAlbum(String title) async {
                    final http.Response response = await http.post(
                      'https://jsonplaceholder.typicode.com/albums',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'title': title,
                      }),
                    );
                    if (response.statusCode == 201) {
                      // If the server did return a 201 CREATED response,
                      // then parse the JSON.
                      return Album.fromJson(json.decode(response.body));
                    } else {
                      // If the server did not return a 201 CREATED response,
                      // then throw an exception.
                      throw Exception(  Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('계정이 없습니다.'))));

                    }
                  }

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
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

InputDecoration getTextFieldDecor(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white),
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

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}