
import 'package:cached_network_image/cached_network_image.dart';
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
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.width * 0.53,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                  imageUrl: '$trailUrl',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress, valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height:
                  MediaQuery.of(context).size.width * 0.45,
                  fit: BoxFit.fill,
                  width:
                  MediaQuery.of(context).size.width * 0.45),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.023,
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
                    Container(
                      width:  MediaQuery.of(context).size.width * 0.23,
                      height:  MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        '$trailName',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "NanumSquareExtraBold",
                            fontSize: MediaQuery.of(context)
                                .size
                                .width *
                                0.03),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.width *
                          0.002,
                    ),
                    Text(
                      '$trailDistance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                              0.034),
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
                          0.023),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,

                ),
              ],
            )
          ],
        ),
      ),
  );
}


