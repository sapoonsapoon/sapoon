import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sapoon/rootPage.dart';
import 'package:sapoon/widget/size.dart';

class ProfileSideMenu extends StatelessWidget {
  FirebaseAuth _auth;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey[300]))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: Text(
              'Settings',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 1,
          ),
          FlatButton.icon(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Route route = MaterialPageRoute(builder: (context) => RootPage());
                Navigator.pushReplacement(context, route);
              },
              icon: Icon(Icons.exit_to_app),
              label: Text(
                'Log out',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
