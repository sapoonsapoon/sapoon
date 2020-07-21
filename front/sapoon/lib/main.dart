
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/rootPage.dart';

import 'package:sapoon/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'LoginPage/LoginPage.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('image');
  runApp(MyApp()); }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('MyApp created');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.white,
      ),
      home: RootPage(),
    );
  }
}