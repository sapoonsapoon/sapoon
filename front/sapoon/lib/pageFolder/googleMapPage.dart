import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/pageFolder/dulle_model.dart';
import 'package:http/http.dart' as http;
import 'data.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}


class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController _controller;

  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  List<Post> googlePost;

  Future<List<Post>> getRegionMark() async {
    double lat =Hive.box('image').get('latitude');
    double lon =Hive.box('image').get('longitude');
    final http.Response response = await http.get(
        Uri.encodeFull(
            'http://34.80.151.71/sapoon/promenade/dullegil/search/gu/geo?x='+lon.toString()+'&y='+lat.toString()),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return makePostList(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('http://34.80.151.71/sapoon/promenade/dullegil/search/gu/geo?x='+lon.toString()+'&y='+lat.toString());
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception();
    }
  }



  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    try{
      googlePost =  await getRegionMark();
      googlePost.forEach((element) {
        allMarkers.add(Marker(
            markerId: MarkerId(element.trailName),
            draggable: false,
            infoWindow:
            InfoWindow(title: element.trailNameshort, snippet: element.trailBriefContents),
            position: LatLng(element.latitude,element.longitude)));
      });


    }catch(e){
        print(e);
    }finally{
      _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
        ..addListener(_onScroll);
    }


  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              width: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          googlePost[index].trailUrl),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  googlePost[index].trailNameshort,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  child: Text(
                                    googlePost[index].trailBriefContents,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  child: Text(
                                    googlePost[index].trailCourseDescription,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.24,
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                '가까운 둘레길 정보 ',
                style: TextStyle(
                  fontFamily: "NanumSquareExtraBold",
                  fontSize: 21.0,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(0.0,0.0), zoom: 14.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(googlePost[_pageController.page.toInt()].latitude,googlePost[_pageController.page.toInt()].longitude),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}