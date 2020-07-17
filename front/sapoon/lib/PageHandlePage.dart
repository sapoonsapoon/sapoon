import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:sapoon/pageFolder/CommunityBoardPage.dart';
import 'package:sapoon/pageFolder/HomePage.dart';
import 'package:sapoon/pageFolder/calendarPage.dart';
import 'package:sapoon/pageFolder/settingPage.dart';
import 'package:sapoon/pageFolder/webviewPage.dart';
import 'package:sapoon/walkRoute/seokchunWalk.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              HomePage(),
              Walks1(),
              CalendarScreen(),
              SettingsOnePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(

          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                textAlign:TextAlign.center,
                activeColor: Colors.green,
                inactiveColor: Colors.black12,
                title: Text('홈'),
                icon: Icon(Icons.home)
            ),
            BottomNavyBarItem(
                textAlign:TextAlign.center,
                activeColor: Colors.blueAccent,
                inactiveColor: Colors.black12,
                title: Text('지도'),
                icon: Icon(Icons.map)
            ),
            BottomNavyBarItem(
                textAlign:TextAlign.center,
                activeColor: Colors.redAccent,
                inactiveColor: Colors.black12,
                title: Text('산책 달력'),
                icon: Icon(Icons.calendar_today)
            ),
            BottomNavyBarItem(
                textAlign:TextAlign.center,
                activeColor: Colors.orangeAccent,
                inactiveColor: Colors.black12,
                title: Text('설정'),
                icon: Icon(Icons.settings)
            ),
          ],
        )
    );
  }
}
