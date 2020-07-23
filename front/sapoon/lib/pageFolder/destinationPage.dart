import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sapoon/pageFolder/data.dart';
import 'package:sapoon/pageFolder/dulleTrailDetailPage.dart';
import 'package:sapoon/pageFolder/communityDetailPage.dart';
import 'package:sapoon/pageFolder/trailEditPage.dart';
import 'package:sapoon/widget/activityWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class DestinationPage extends StatefulWidget {
  final Post posts;

  DestinationPage({this.posts});

  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  Future<List<Activity>> futureActivity;
  List<Activity> countActivity = new List<Activity>();

  Future<List<Activity>> getActivityRecent() async {
    try {
      Future<List<Activity>> activityLis =
          ActivityCommunityService.getCommunityAcitivys(
              'http://34.80.151.71/sapoon/community/dulle/' +
                  widget.posts.seq.toString());
      return activityLis;
    } catch (e) {
      print(e);
      return countActivity;
    }
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  void initState() {
    futureActivity = getActivityRecent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: widget.posts.trailUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      child: CachedNetworkImage(
                        imageUrl: widget.posts.trailUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 30.0,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DulleTrailDetailPage(
                                            posts: widget.posts,
                                          )));
                            },
                          ),
                          IconButton(
                            icon: Icon(FontAwesomeIcons.sortAmountDown),
                            iconSize: 25.0,
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  bottom: 20.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.posts.trailName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 15.0,
                            color: Colors.green,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            widget.posts.trailDistance,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 20.0,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 25.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: futureActivity,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text("해당 둘레길에 대해 후기를 남겨주세요!!"),
                      ],
                    ));
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text("해당 둘레길에 대해 후기를 남겨주세요!"),
                        ],
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            Activity activity = snapshot.data[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrailDetailPage(
                                            activity: activity,
                                          ))),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.14,
                                        MediaQuery.of(context).size.width *
                                            0.01,
                                        10.0,
                                        0),
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                          20.0,
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                          0.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 170.0,
                                                child: Text(
                                                  activity.contents,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    '${activity.totalScore}' +
                                                        '점',
                                                    style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 170.0,
                                            child: Text(
                                              activity.writer,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 2.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              _buildRatingStars(
                                                  activity.rating.toInt()),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  activity.startTimes[0] +
                                                      '~' +
                                                      activity.startTimes[1],
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: 15.0,
                                    bottom: 15.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        imageUrl: activity.imgUrl,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.blueAccent),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text("해당 둘레길에 대해 후기를 남겨주세요!"),
                      ],
                    ));
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrailEditPage(
                        seq: widget.posts.seq,
                      )));
        },
        child: Icon(Icons.edit),
        heroTag: null,
      ),
    );
  }
}
