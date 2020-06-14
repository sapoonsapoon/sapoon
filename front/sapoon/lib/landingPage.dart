import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: <Widget>[

                      ],
                    ),
                  )
                ),
              );
             }
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: const<BottomNavigationBarItem>[
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text(''),
           backgroundColor: Colors.green

         ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
              backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
              backgroundColor: Colors.green
          ),
        ],
      ),
    );
  }
}
