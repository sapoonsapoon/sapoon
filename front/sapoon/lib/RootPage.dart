import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:sapoon/SignUpPage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'SAPOON',
                style: TextStyle(
                    fontFamily: "NanumSquareExtraBold",
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '산책하기 정말 좋은 날',
                style: TextStyle(
                    fontFamily: "NanumSquareRegular",
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.744,
                height: MediaQuery.of(context).size.width * 0.100,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  obscureText: true,
                  controller: _emailController,
                  decoration: getTextFieldDecor('Email'),
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
              Padding(
                padding: EdgeInsets.all(33.0),
              ),

              InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.744,
                  height: MediaQuery.of(context).size.width * 0.125,
                  child: Center(
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Text(
                        '아이디 찾기 |  ', style: TextStyle(
                          fontFamily: "NanumSquareRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    ),
                  InkWell(
                    child: Text(
                      '비밀번호 찾기  |  ', style: TextStyle(
                        fontFamily: "NanumSquareRegular",
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>SignUpPage()
                      ));
                    },
                    child: Text(
                      '회원가입  ', style: TextStyle(
                        fontFamily: "NanumSquareRegular",
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                ],
              )

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
