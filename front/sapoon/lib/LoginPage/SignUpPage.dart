import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../pageFolder/HomePage.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

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
            '회원가입 화면',
            textAlign: TextAlign.right,
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40.0),
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
                          hintText: '아이디',
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
                      padding: EdgeInsets.all(5.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.744,
                      height: MediaQuery.of(context).size.width * 0.13,
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: "NanumSquareExtraBold",
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        controller: _pwController,
                        decoration: InputDecoration(
                          hintText: '비밀번호 ',
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
                          prefixIcon: Icon(Icons.https),
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
                      padding: EdgeInsets.all(5.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.367,
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: TextFormField(
                            style: TextStyle(
                                fontFamily: "NanumSquareExtraBold",
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
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
                                return "빈칸은 허용할 수 없어요:)";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.01),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.367,
                          height: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black12,
                          )),
                          child: DropdownButton<String>(
                            underline: Text(''),
                            isExpanded: true,
                            value: dropdownValue,
                            iconSize: 24,
                            hint: Container(
                              alignment: Alignment.centerRight,
                              width: 100,
                              child:
                                  Text("Hint text", textAlign: TextAlign.end),
                            ),
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontFamily: "NanumSquareExtraBold",
                                fontSize: 16),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['    남자', '    여자']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, textAlign: TextAlign.right),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (date) {},
                          onConfirm: (date) {
                            print('완료 $date');
                            String dateYearMonthDay = DateFormat("yyyy-MM-dd").format(date);
                            _incrementCounter(dateYearMonthDay);
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
                      padding: EdgeInsets.all(5.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.744,
                      height: MediaQuery.of(context).size.width * 0.13,
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black38, fontWeight: FontWeight.bold),
                        controller: _nicknameController,
                        decoration: InputDecoration(
                          hintText: '닉네임',
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
                          prefixIcon: Icon(Icons.face),
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
                      padding: EdgeInsets.all(5.0),
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
                      padding: EdgeInsets.all(7.0),
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          createSignUp(
                            context,
                            _idController.text,
                            _pwController.text,
                            _nameController.text,
                            _sexController.text,
                            show_log,
                            _emailController.text,
                            _nicknameController.text,
                          );
                        } else {
                          final snackbar = SnackBar(content: Text('전부 다 입력해주세요.'));
                          Scaffold.of(context).showSnackBar(snackbar);
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

Future createSignUp(
    BuildContext context,
    String id,
    String password,
    String name,
    String gender,
    String birthday,
    String email,
    String nickname) async {
  print('시작합니다');
  print(birthday);
  final http.Response response = await http.post(
    'http://34.80.151.71/sapoon/member/regist',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '$id',
      'password': "$password",
      'name': '$name',
      'gender': '$gender',
      'birthday': '$birthday',
      'email': '$email',
      'nickname': '$nickname',
    }),
  );
  if (response.statusCode == 200) {
    final snackbar = SnackBar(content:  Text('회원가입이 정상적으로 되었습니다.'));
    Scaffold.of(context).showSnackBar(snackbar);
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/');
    });


  } else if(response.statusCode == 401){
    print('ID가 중복일때 나오는 에러');
    final snackbar = SnackBar(content: Text('중복된 ID가 존재합니다.'));
    Scaffold.of(context).showSnackBar(snackbar);
  } else{
    final snackbar = SnackBar(content:  Text(utf8.decode(response.bodyBytes)));
    Scaffold.of(context).showSnackBar(snackbar);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception();
  }
}
