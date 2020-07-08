import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PasswordFindPage extends StatefulWidget {
  @override
  _PasswordFindPageState createState() => _PasswordFindPageState();
}

class _PasswordFindPageState extends State<PasswordFindPage> {
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

  String show_log='생일을 입력해주세요';
  String dropdownValue = '    남자';

  void _incrementCounter(String value) {
    setState(() {
      show_log =value;
      print(show_log);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

        appBar: AppBar(
          title: Text('비밀번호 찾기', textAlign: TextAlign.right,),

        ),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(

            child: SafeArea(
              child:  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.all(50.0),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.744,
                        height: MediaQuery.of(context).size.width * 0.13,
                        child: TextFormField(
                          style: TextStyle(
                              fontFamily: "NanumSquareExtraBold",
                              color: Colors.black45, fontWeight: FontWeight.bold),
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _idController,
                          decoration: InputDecoration(
                            hintText: '아이디',
                            hintStyle: TextStyle(color: Colors.black45,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.6,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon: Icon(Icons.account_circle),
                          ),

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
                        padding: EdgeInsets.all(2.0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.744,
                            height: MediaQuery.of(context).size.width * 0.13,
                            child: TextFormField(
                              style: TextStyle(
                                  fontFamily: "NanumSquareExtraBold",
                                  color: Colors.black45, fontWeight: FontWeight.bold),
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: '이름 ',
                                hintStyle: TextStyle(color: Colors.black45),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 0.6,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 1,
                                  ),
                                ),
                                fillColor: Colors.transparent,
                                filled: true,
                                prefixIcon: Icon(Icons.person_outline),
                              ),
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
                      Padding(
                        padding: EdgeInsets.all(2.0),
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
                          height: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12,)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                show_log,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.744,
                        height: MediaQuery.of(context).size.width * 0.13,
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.black45, fontWeight: FontWeight.bold),
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: '이메일 ',
                            hintStyle: TextStyle(color: Colors.black45),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0.6,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
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
                          final snackbar = SnackBar(content: Text('계정이 없습니다.'));
                          Scaffold.of(context).showSnackBar(snackbar);
                          createAlbum(context,
                            _idController.text,
                            _nameController.text,
                              show_log,
                            _emailController.text,
                          );
//                          Navigator.push(context, MaterialPageRoute(
//                              builder: (context)=>PasswordFindResultPage()
//                          ));
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
                              "비밀번호 찾기",
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
    String name,
    String birthday,
    String email) async {
  final http.Response response = await http.post(
    'http://35.194.192.57/sapoon/member/find/password',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '$id',
      'name':'$name',
      'birthday':'$birthday',
      'email': '$email',
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('성공적이에요!');

  } else {
    print(name);
    print('Response status: ${response.statusCode}');
    print("한글 원인이에요:  "+utf8.decode(response.bodyBytes)); // 한
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}

