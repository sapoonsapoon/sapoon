
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/LoginPage/LoginPage.dart';
import 'package:sapoon/rootPage.dart';

class SettingsOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  bool _dark;
  String _nickName = Hive.box('image').get('nickname');
  String _photoUrl = Hive.box('image').get('profilePhoto');
  String _sapoon = Hive.box('image').get('loginWithSapoon');
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    super.initState();
    _dark = false;
    if(_sapoon == '1'){
      _photoUrl='https://picsum.photos/200/300';
    }
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 21.0,fontFamily: "NanumSquareExtraBold",color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.green,
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        _nickName+"님",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_photoUrl),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.green,
                          ),
                          title: Text("회원정보 수정"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.server,
                            color: Colors.green,
                          ),
                          title: Text("비밀번호 변경"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          title: Text("산책로 선호 위치"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {

                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          title: Text("로그아웃", style: TextStyle(color: Colors.blueAccent),),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            _googleSignIn.signOut();

                            Route route = MaterialPageRoute(builder: (context) => RootPage());
                            Navigator.pushReplacement(context, route);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "알림 Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.green,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("메시지 알림"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.green,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Received newsletter"),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: Colors.green,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received Offer Notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.green,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received App Updates"),
                    onChanged: null,
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}