
import 'package:flutter/material.dart';
import 'package:sapoon/pageFolder/CommunityBoardPage.dart';
import 'package:sapoon/pageFolder/HomePage.dart';
import 'package:sapoon/pageFolder/calendarPage.dart';
import 'package:sapoon/pageFolder/googleMapPage.dart';
import 'package:sapoon/pageFolder/profile_page.dart';
import 'package:sapoon/pageFolder/settingPage.dart';
import 'package:sapoon/widget/size.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CommunityBoardPage(),
    GoogleMapPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery
          .of(context)
          .size;
    }
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(activeIconPath: "assets/home_selected.png", iconPath: "assets/home.png"),
          _buildBottomNavigationBarItem(activeIconPath: "assets/search_selected.png", iconPath: "assets/search.png"),
          _buildBottomNavigationBarItem(activeIconPath: "assets/heart_selected.png", iconPath: "assets/heart.png"),
          _buildBottomNavigationBarItem(activeIconPath: "assets/profile_selected.png", iconPath: "assets/profile.png"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({String activeIconPath, String iconPath}) {
    return BottomNavigationBarItem(
      activeIcon: activeIconPath == "null" ? "null" : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      title: Text(''),
    );
  }

  void _onItemTapped(int index) {

      setState(() {
        _selectedIndex = index;
      });
  }





//  int _currentIndex = 0;
//  PageController _pageController;
//
//  @override
//  void initState() {
//    super.initState();
//    _pageController = PageController();
//  }
//
//  @override
//  void dispose() {
//    _pageController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: SizedBox.expand(
//          child: PageView(
//            controller: _pageController,
//            onPageChanged: (index) {
//              setState(() => _currentIndex = index);
//            },
//            children: <Widget>[
//              HomePage(),
//              CommunityBoardPage(),
//              GoogleMapPage(),
//              ProfilePage()
//            ],
//          ),
//        ),
//        bottomNavigationBar: BottomNavyBar(
//          selectedIndex: _currentIndex,
//          onItemSelected: (index) {
//            setState(() => _currentIndex = index);
//            _pageController.jumpToPage(index);
//          },
//          items: <BottomNavyBarItem>[
//            BottomNavyBarItem(
//                textAlign:TextAlign.center,
//                activeColor: Colors.green,
//                inactiveColor: Colors.black12,
//                title: Text('홈'),
//                icon: Icon(Icons.home)
//            ),
//            BottomNavyBarItem(
//                textAlign:TextAlign.center,
//                activeColor: Colors.blueAccent,
//                inactiveColor: Colors.black12,
//                title: Text('지도'),
//                icon: Icon(Icons.map)
//            ),
//            BottomNavyBarItem(
//                textAlign:TextAlign.center,
//                activeColor: Colors.redAccent,
//                inactiveColor: Colors.black12,
//                title: Text('지역구 산책'),
//                icon: Icon(Icons.trip_origin)
//            ),
//            BottomNavyBarItem(
//                textAlign:TextAlign.center,
//                activeColor: Colors.orangeAccent,
//                inactiveColor: Colors.black12,
//                title: Text('설정'),
//                icon: Icon(Icons.settings)
//            ),
//          ],
//        )
//    );
//  }
}
