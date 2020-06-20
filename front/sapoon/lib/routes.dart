import 'package:flutter/material.dart';
import 'package:sapoon/RootPage.dart';
import 'landingPage.dart';

final routes = {
  '/' : (BuildContext context) => RootPage(),
  '/login': (BuildContext context) => RootPage(),
  '/main': (BuildContext context) => LandingPage()
};