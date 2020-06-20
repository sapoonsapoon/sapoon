
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapoon/routes.dart';

import 'RootPage.dart';

void main() => runApp(MyApp());

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
      routes: routes,
    );
  }
}