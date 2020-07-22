import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sapoon/LoginPage/LoginPage.dart';
import 'package:sapoon/PageHandlePage.dart';
import 'package:sapoon/loadingPage.dart';
import 'package:sapoon/pageFolder/HomePage.dart';

class RootPage extends StatelessWidget {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    print('root_page created');
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          if (snapshot.hasData) {
            user= snapshot.data;
            Hive.box('image').put('nickname',user.displayName);
            Hive.box('image').put('profilePhoto',user.photoUrl);
            return LandingPage();
          }
          return LoginPage();
        }
      },
    );
  }
}