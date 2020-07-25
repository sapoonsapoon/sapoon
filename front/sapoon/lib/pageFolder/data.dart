import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:sapoon/widget/activityWidget.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    final http.Response response = await http.get(
        Uri.encodeFull(
            'http://34.80.151.71/sapoon/promenade/dullegil/search?dullegilName=' +
                query),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      List<Post> returnValue =
      makePostList(json.decode(utf8.decode(response.bodyBytes)));
      if (returnValue.length == 0) {
        return List.generate(0, (index) {
          return {'name': '다른 산책로를 찾아보세요', 'trailDistance': '산책로가 없습니다'};
        });
      } else {
        return List.generate(returnValue.length, (index) {
          return {
            'seq': returnValue[index].seq,
            'name': returnValue[index].trailName,
            'trailDistance': returnValue[index].trailDistance,
            'trailUrl': returnValue[index].trailUrl,
            'trailBriefContents': returnValue[index].trailBriefContents,
            'post': returnValue[index],

          };
        });
      }
    } else {
      return List.generate(1, (index) {
        return {'name': '해당 요청의 데이터가 없습니다', 'trailDistance': '추천 리스트가 없습니다'};
      });
    }
  }
}

class Post {
  int seq;
  String trailUrl;
  String trailName;
  String trailDistance;
  String trailBriefContents;
  String trailShortName;
  List<Activity> activities;
  String trailDescription;
  String trailCourseDescription;
  String trailDifficulty;
  double trailDistanceDetail;
  String trailLeadTime;
  String trailDrinkingWaterInfo;
  String trailToiletInfo;
  String trailCafeteriaInfo;
  String trailKakaoMapImgUrl;
  double latitude;
  double longitude;
  String trailUrl2;
  String trailUrl3;
  String trailUrl4;
  String trailNameshort;

  Post({
    this.seq,
    this.trailUrl,
    this.trailName,
    this.trailDistance,
    this.trailBriefContents,
    this.trailShortName,
    this.activities,
    this.trailDescription,
    this.trailCourseDescription,
    this.trailDifficulty,
    this.trailDistanceDetail,
    this.trailLeadTime,
    this.trailDrinkingWaterInfo,
    this.trailToiletInfo,
    this.trailCafeteriaInfo,
    this.trailKakaoMapImgUrl,
    this.longitude,
    this.latitude,
    this.trailUrl2,
    this.trailUrl3,
    this.trailUrl4,
    this.trailNameshort,
  });
}

class totalPointAvg{
  int dulleSeq;
  double totalCount;
  double avgScore;

  totalPointAvg({
    this.dulleSeq,
    this.totalCount,
    this.avgScore,
    });
}

totalPointAvg makeTotalPointAvgList(List<dynamic> json){

  totalPointAvg values = totalPointAvg();

    double avgScore = json[0]['avgScore'];
    double totalCount = json[0]['totalCount'];
    int dulleSeq = json[0]['dulleSeq'];

  Hive.box('image').put('avgScore',avgScore);
  Hive.box('image').put('totalCount',totalCount);
  Hive.box('image').put('dulleSeq',dulleSeq.toString());


  values.dulleSeq = dulleSeq;
  values.avgScore = avgScore;
  values.totalCount = totalCount;

  return values;

}

List<Post> makePostList(List<dynamic> json) {

  List<Post> values = List<Post>();
  for (int i = 0; i < json.length; i++) {
    String trailsJsonName = json[i]['name'];
    String trailCourseName = json[i]['courseName'];
    Map<String, dynamic> trailUrl = json[i]['dullegilDetailVo'];
    int seq = json[i]['seq'];
    String trailDistance = json[i]['distance'];

    values.add(Post(
      seq: seq,
      trailUrl: trailUrl['thumbnail'],
      trailName: trailsJsonName + '\n' + trailCourseName,
      trailDistance: trailDistance,
      trailBriefContents: json[i]['region1'],
      trailShortName: json[i]['name'],
      trailDescription:json[i]['description'],
      trailCourseDescription:json[i]['courseDescription'],
      trailDifficulty:json[i]['difficulty'],
      trailDistanceDetail:json[i]['distanceDetail'],
      trailLeadTime:json[i]['leadTime'],
      trailDrinkingWaterInfo:json[i]['drinkingWaterInfo'],
      trailToiletInfo:json[i]['toiletInfo'],
      trailCafeteriaInfo:json[i]['cafeteriaInfo'],
      trailKakaoMapImgUrl:trailUrl['imgPath1'],
      trailUrl2:trailUrl['imgPath2'],
      trailUrl3:trailUrl['imgPath3'],
      trailUrl4:trailUrl['imgPath4'],
      latitude: json[i]['latitude'],
      longitude: json[i]['longitude'],
      trailNameshort: json[i]['courseName'],
    ));
  }
  return values;
}

class ActivityService {
  static Future<List<Activity>> getAcitivys() async {
    final http.Response response = await http.get(
        Uri.encodeFull(
            'http://34.80.151.71/sapoon/community'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      Map<String,dynamic> returnValue = json.decode(utf8.decode(response.bodyBytes));
      List<Activity> listActivity = makeActivityList(returnValue);
      return listActivity;
    } else {
      print('이상한 결과');
      throw Exception(
      );
    }
  }
}


class ActivityCommunityService {
  static Future<List<Activity>> getCommunityAcitivys(String url) async {
    print(url);
    final http.Response response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      Map<String,dynamic> returnValue = json.decode(utf8.decode(response.bodyBytes));
      List<Activity> listActivity = makeActivityList(returnValue);
      return listActivity;
    } else {
      print("예외가 발생!!!!!!!!!!!!!");
      throw Exception();
    }
  }
}

Post makePost(Map<String,dynamic> json){
  Post values = Post();
  if(json != null){
    Map<String, dynamic> trailUrl = json['dullegilDetailVo'];
    String trailsJsonName = json['name'];
    String trailCourseName = json['courseName'];
    String trailDistance = json['distance'];
    values =Post(
      seq: json['seq'],
      trailUrl: trailUrl['thumbnail'],
      trailName: trailsJsonName + '\n' + trailCourseName,
      trailDistance: trailDistance,
      trailBriefContents: json['region1'],
      trailShortName: json['name'],
      trailDescription:json['description'],
      trailCourseDescription:json['courseDescription'],
      trailDifficulty:json['difficulty'],
      trailDistanceDetail:json['distanceDetail'],
      trailLeadTime:json['leadTime'],
      trailDrinkingWaterInfo:json['drinkingWaterInfo'],
      trailToiletInfo:json['toiletInfo'],
      trailCafeteriaInfo:json['cafeteriaInfo'],
      trailKakaoMapImgUrl:trailUrl['imgPath1'],
      trailUrl2:trailUrl['imgPath2'],
      trailUrl3:trailUrl['imgPath3'],
      trailUrl4:trailUrl['imgPath4'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      trailNameshort: json['courseName'],
    );
    return values;
  }
  return values;
}

List<Activity> makeActivityList(Map<String,dynamic> json) {
  List<Activity> values = List<Activity>();
  for (int i = 0; i < json['result'].length; i++) {
    values.add(Activity(
      seq: json['result'][i]['seq'],
      writer: json['result'][i]['writer'],
      contents: json['result'][i]['contents'],
      score1: json['result'][i]['score1'],
      score2: json['result'][i]['score2'],
      score3: json['result'][i]['score3'],
      score4: json['result'][i]['score4'],
      rating: json['result'][i]['starScore'],
      totalScore: json['result'][i]['totalScore'],
      starScore: json['result'][i]['starScore'],
      startTimes: [json['result'][i]['startTime'], json['result'][i]['endTime']],
      imgUrl: json['result'][i]['imgUrl'],
      dulleSeq: json['result'][i]['dulleSeq'],
      userDulleWrite: json['result'][i]['userDulleWrite'],
    ));
  }
  return values;
}

