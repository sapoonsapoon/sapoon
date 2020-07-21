import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/LoginPage/SignUpPage.dart';
import 'package:sapoon/PageHandlePage.dart';
import 'package:sapoon/idFindPage.dart';
import 'package:sapoon/LoginPage/passwordFindPage.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/images/main.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
              child: SingleChildScrollView(
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
                    controller: _emailController,
                    decoration: getTextFieldDecor('ID'),
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
                  padding: EdgeInsets.all(5.0),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.128,
                      right: MediaQuery.of(context).size.width * 0.128),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.blue,
                    onPressed: () {},
                    child: SignInWithGoogle(
                      onPressed: () {
                        _handleSignIn().then((user) {
                          print(user);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.128,
                      right: MediaQuery.of(context).size.width * 0.128),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {},
                    color: Color.fromRGBO(73, 101, 159, 1),
                    child: SignInWithFacebook(
                      onPressed: () {
                        _handleSignInFacebook().then((user) {

                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                InkWell(
                  onTap: () {
                    createSignIn(
                        context, _emailController.text, _pwController.text);
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IdFindPage()));
                      },
                      child: Text(
                        '아이디 찾기 |  ',
                        style: TextStyle(
                            fontFamily: "NanumSquareRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordFindPage()));
                      },
                      child: Text(
                        '비밀번호 찾기  |  ',
                        style: TextStyle(
                            fontFamily: "NanumSquareRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        '회원가입  ',
                        style: TextStyle(
                            fontFamily: "NanumSquareRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future createSignIn(
    BuildContext context,
    String id,
    String password,
  ) async {
    final http.Response response = await http.post(
      'http://34.80.151.71/sapoon/member/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': '$id',
        'password': "$password",
        'macId': '10.22.33.453',
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> headersDynamic = response.headers;
      print('성공적이에요!');
      print('Response body: ' + utf8.decode(response.bodyBytes));
      Hive.box('image').put(
          'nickname', json.decode(utf8.decode(response.bodyBytes))['nickname']);
      Hive.box('image').put('headers', headersDynamic['authorization']);
      Hive.box('image').put('loginWithSapoon', '1');
      String value = Hive.box('image').get('headers');
      Route route = MaterialPageRoute(builder: (context) => LandingPage());
      Navigator.pushReplacement(context, route);
    } else if (response.statusCode == 401) {
      print(response.statusCode);
      print('ID가 중복일때 나오는 에러');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      showInSnackBar(utf8.decode(response.bodyBytes));
    } else {
      showInSnackBar(utf8.decode(response.bodyBytes));
      print('Response status: ${response.statusCode}');
      print('Response body: ' + utf8.decode(response.bodyBytes));
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception();
    }
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser;
    FirebaseUser user;
    try{
      googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      user = (await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken)))
          .user;
      print("signed in " + user.displayName);
    }catch(response){
      showInSnackBar(response.toString());
    }
    return user;
  }
  Future<FirebaseUser> _handleSignInFacebook() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FacebookLogin facebookLogin = FacebookLogin();
    AuthResult authResult;
    try{
      FacebookLoginResult result =
      await facebookLogin.logIn(['email', 'public_profile']);
      AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      authResult = await auth.signInWithCredential(credential);
    }catch(response){
      showInSnackBar(response.toString());
    }
    FirebaseUser user = authResult.user;
    return user;
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
