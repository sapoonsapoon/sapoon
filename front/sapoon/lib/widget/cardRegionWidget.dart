
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Card cardRegionWidget({
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
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.39,
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
                MediaQuery.of(context).size.width * 0.23,
                fit: BoxFit.fill,
                width:
                MediaQuery.of(context).size.width * 0.3),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width:
                MediaQuery.of(context).size.width * 0.01,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.26,
                    height:  MediaQuery.of(context).size.width * 0.07,
                    child: Text(
                      '$trailName',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "NanumSquareExtraBold",
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                              0.027),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.001,
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
                            0.03),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}


