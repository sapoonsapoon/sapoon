import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sapoon/widget/activityWidget.dart';


class BackendService {
    static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 1));
    final http.Response response = await http.get(
        Uri.encodeFull(
            'http://34.80.151.71/sapoon/promenade/dullegil/search?dullegil_name=' +
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
        return List.generate(5, (index) {
          return {
            'name': returnValue[index].trailName,
            'trailDistance': returnValue[index].trailDistance,
            'trailUrl': returnValue[index].trailUrl,
            'trailBriefContents': returnValue[index].trailBriefContents,
            'post': returnValue[index],
          };
        });
      }
    } else {
      return List.generate(0, (index) {
        return {'name': '해당 요청의 데이터가 없습니다', 'trailDistance': '추천 리스트가 없습니다'};
      });
      throw Exception();
    }
  }
}

class Post {
  String trailUrl;
  String trailName;
  String trailDistance;
  String trailBriefContents;
  List<Activity> activities;

  Post({
    this.trailUrl,
    this.trailName,
    this.trailDistance,
    this.trailBriefContents,
    this.activities,
  });
}
List<Post> makePostList(List<dynamic> json) {
  List<Post> values = List<Post>();
  for (int i = 0; i < json.length; i++) {
    String trailsJsonName = json[i]['name'];
    String trailCourseName = json[i]['courseName'];
    values.add(Post(
      trailUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRo93aJCVkzf3LytZ4x7npQ6c_yLz9hTl7BDg&usqp=CAU',
      trailName: trailsJsonName + '\n' + trailCourseName,
      trailDistance: '2km',
      trailBriefContents: json[i]['region1'],
      activities: activities,
    ));
  }
  return values;
}


List<Activity> activities = [
  Activity(
    imageUrl: 'lib/assets/images/dulle3.jpeg',
    name: '과수원을 걷는 느낌이었다 좋은 향기가 가득한 산책로',
    type: '백상우',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'lib/assets/images/dulle1.jpeg',
    name: '연인이랑 손잡고 걷기에 아주 좋은 산책로',
    type: '지존 이승권',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'lib/assets/images/dulle2.jpeg',
    name: '태양이 나뭇잎에 가려져서 느껴지는 따뜻한 온기와 산책로에서 불어오는 바람이 좋았다. ',
    type: '사푼 여신 사푼사푼',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];
