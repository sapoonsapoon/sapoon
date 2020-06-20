import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'idFindResultPage.dart';

class IdFindPage extends StatefulWidget {
  @override
  _IdFindPageState createState() => _IdFindPageState();
}

class _IdFindPageState extends State<IdFindPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String show_log = '생일을 입력해주세요';

  String dropdownValue = '    남자';

  void _incrementCounter(String value) {
    setState(() {
      show_log = value;
      print(show_log);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '아이디 찾기',
            textAlign: TextAlign.right,
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(70.0),
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
                          color: Colors.black45,
                          fontWeight: FontWeight.bold),
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: '이름',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
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
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onChanged: (date) {},
                        onConfirm: (date) {
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
                          border: Border.all(
                        color: Colors.black12,
                      )),
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
                        hintText: '이메일',
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
                      createAlbum(
                        context,
                        _idController.text,
                        show_log,
                        _emailController.text,

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
                          "아이디 찾기",
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

Future createAlbum(
    BuildContext context,
    String name,
    String birthday,
    String email,) async {
  print(name);
  print(birthday);
  print(email);
  final http.Response response = await http.post(
    'http://35.194.192.57/sapoon/member/find/id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': '$name',
      'birthday': '$birthday',
      'email': '$email',
    }),
  );
  if (response.statusCode == 200) {

    print('아이디를 찾았어요!');
    print('Response body: ${response.body}');
    var responseValue =json.decode(response.body);
    var user = idJson(responseValue);
    print(user.id);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => IdFindResultPage(user.id)));

  } else {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}

class idJson{
  String id;

  idJson(Map<String,dynamic> data){
    id = data['id'];
  }

}