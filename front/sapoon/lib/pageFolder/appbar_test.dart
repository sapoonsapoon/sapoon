import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/pageFolder/productPage.dart';
import 'package:sapoon/widget/destination_carousel.dart';
class appbar extends StatefulWidget {
  @override
  _appbarState createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  int _selectedIndex = 0;
  int _currentTab = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            DestinationCarousel(),
          ],
        ),
      ),
    );
  }
}
