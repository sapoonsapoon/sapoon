
import 'package:flutter/material.dart';

Card CardWidget({
  BuildContext context,
  String trailUrl,
  String trailName,
  String trailDistance,
  String briefContents,
}) {
  return Card(
      margin: EdgeInsets.only(
        left: 10.0, right: 10.0, top: 0.0, bottom: 1.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                  '$trailUrl',
                  height:
                  MediaQuery.of(context).size.width * 0.55,
                  fit: BoxFit.fill,
                  width:
                  MediaQuery.of(context).size.width * 0.55),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$trailName',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                              0.04),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    Text(
                      ' $trailDistance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                              0.04),
                    ),
                  ],
                ),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  '$briefContents',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "NanumSquareRegular",
                      fontSize:
                      MediaQuery.of(context).size.width *
                          0.03),
                ),
              ],
            )
          ],
        ),
      ),
  );
}


