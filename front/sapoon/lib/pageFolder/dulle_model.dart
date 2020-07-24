import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sapoon/pageFolder/data.dart';

class Dulle {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Dulle(
      {this.shopName,
        this.address,
        this.description,
        this.thumbNail,
        this.locationCoords});
}



//                child: Container(
//                    margin: EdgeInsets.symmetric(
//                      horizontal: 10.0,
//                      vertical: 20.0,
//                    ),
//                    height: MediaQuery.of(context).size.height*0.2,
//                    width: MediaQuery.of(context).size.width*0.7,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.black54,
//                            offset: Offset(0.0, 4.0),
//                            blurRadius: 10.0,
//                          ),
//                        ]),
//                    child: Container(
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(10.0),
//                            color: Colors.white),
//                        child: Row(children: [
//                          Container(
//                              height: MediaQuery.of(context).size.height*0.2,
//                              width: MediaQuery.of(context).size.width*0.2,
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.only(
//                                      bottomLeft: Radius.circular(10.0),
//                                      topLeft: Radius.circular(10.0)),
//                                  image: DecorationImage(
//                                      image: NetworkImage(
//                                          dulleTrail[index].trailUrl),
//                                      fit: BoxFit.cover))),
//                          SizedBox(width: 5.0),
//                          Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Text(
//                                  dulleTrail[index].trailNameshort,
//                                  style: TextStyle(
//                                      fontSize: 12.5,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                                Container(
//                                  width: MediaQuery.of(context).size.width*0.45,
//                                  child: Text(
//                                    dulleTrail[index].trailBriefContents,
//                                    style: TextStyle(
//                                        fontSize: 12.0,
//                                        fontWeight: FontWeight.w600),
//                                        overflow: TextOverflow.ellipsis,
//                                        maxLines: 1,
//                                  ),
//                                ),
//                                Container(
//                                  width: MediaQuery.of(context).size.width*0.45,
//                                  child: Text(
//                                    dulleTrail[index].trailCourseDescription,
//                                    style: TextStyle(
//                                        fontSize: 11.0,
//                                        fontWeight: FontWeight.w300),
//                                    overflow: TextOverflow.ellipsis,
//                                    maxLines: 2,
//                                  ),
//                                )
//                              ])
//                        ]))))
//          ])),
//    );
//  }




//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//          appBar: AppBar(
//          elevation: 0,
//          brightness: Brightness.light,
//          title: Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              SizedBox(
//                height: MediaQuery.of(context).size.width * 0.24,
//                width: MediaQuery.of(context).size.width * 0.04,
//              ),
//              Text(
//                '가까운 둘레길 정보 ',
//                style: TextStyle(
//                  fontFamily: "NanumSquareExtraBold",
//                  fontSize: 21.0,
//                ),
//              ),
//            ],
//          ),
//        ),
//        body: Stack(
//          children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height - 50.0,
//              width: MediaQuery.of(context).size.width,
//              child: GoogleMap(
//                initialCameraPosition: CameraPosition(
//                    target: LatLng(0.0,0.0), zoom: 14.0),
//                markers: Set.from(allMarkers),
//                onMapCreated: mapCreated,
//              ),
//            ),
//            Positioned(
//              bottom: 20.0,
//              child: Container(
//                height: MediaQuery.of(context).size.height*0.2,
//                width: MediaQuery.of(context).size.width,
//                child: PageView.builder(
//                  controller: _pageController,
//                  itemCount: 5,
//                  itemBuilder: (BuildContext context, int index) {
//                    return _coffeeShopList(index);
//                  },
//                ),
//              ),
//            )
//          ],
//        ));
//  }
//
//  void mapCreated(controller) {
//    setState(() {
//      _controller = controller;
//    });
//  }
//
//  moveCamera() {
//    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: LatLng(dulleTrail[_pageController.page.toInt()].latitude,dulleTrail[_pageController.page.toInt()].longitude),
//        zoom: 14.0,
//        bearing: 45.0,
//        tilt: 45.0)));
//  }
final List<Post> dulleTrail = [
  Post(
    seq: 41,
    trailUrl: "https://storage.googleapis.com/sapoon-promenade-img/0041_02.jpg",
    trailName:  "동네 골목길 관광 코스"+ '\n' + "세종한울길",
    trailDistance: "1~5Km미만",
    trailBriefContents: "서울 종로구",
    trailShortName: "동네 골목길 관광 코스",
    trailDescription: "세종한울길은 세종대왕의 우수한 업적과 숨결을 그대로 느낄 수 있는 우리 종로의 길입니다. 백성을 사랑하고 나라를 염려하며 끊임없이 조선을 발전시키려 했던 세종대왕의 깊은 뜻과 마음이 담겨있는 세종한울길을 따라 걸으며 세종대왕과 한층 가깝게 만날수 있습니다.",
    trailCourseDescription: "세종벨트 인포센터 → 광화문 광장 '세종이야기'홍보관 → 세종대왕 동상 → 세종대왕 생가 터 → 맹사성 집터 → 경복궁 → 관상감 관천대",
    trailDifficulty:"보통",
    trailDistanceDetail:4,
    trailLeadTime:"1시간30분",
    trailDrinkingWaterInfo: "",
    trailToiletInfo:"광화문역, 안국역, 세종이야기, 고궁 박물관, 개방화장실(삼청동)",
    trailCafeteriaInfo:"세종이야기(카페, 식사), 거리 중간마다 편의점(가게)가 있음",
    trailKakaoMapImgUrl:"https://storage.googleapis.com/sapoon-promenade-img/0041_01.jpg",
    trailUrl2:"https://storage.googleapis.com/sapoon-promenade-img/0041_02.jpg",
    trailUrl3:"https://storage.googleapis.com/sapoon-promenade-img/0041_03.jpg",
    trailUrl4:"https://storage.googleapis.com/sapoon-promenade-img/0041_04.jpg",
    latitude: 37.579336,
    longitude: 126.979487,
    trailNameshort: "세종한울길",
  ),
  Post(
    seq: 93,
    trailUrl: "https://storage.googleapis.com/sapoon-promenade-img/0093_02.jpg",
    trailName:  "서울 한양도성 길"+ '\n' + "01코스 북악산",
    trailDistance: "1~5Km미만",
    trailBriefContents: "서울 종로구",
    trailShortName: "서울 한양도성 길",
    trailDescription: "백악마루 아래 서울이 열리다 북악산코스는 창의문을 시작으로 숙정문을 거쳐 혜화문에 도달하는 코스이다. 창의문휴게소에서 간단한 출입절차를 거치며, 성곽을 따라 걷는 동안에 성곽유적 뿐만 아니라 서울 시내를 한눈에 바라볼 수 있는 조망명소가 많이 위치해 볼거리가 매우 풍부하다. 와룡공원을 지나 시내로 접하는 구간부터는 성곽이 멸실되었으며 좁은 마을길을 지나지만 잃어버린 역사의 흔적을 따라 걷는 동안 우리의 역사문화유적에 대한 경이로움을 느낄 수 있다",
    trailCourseDescription: "창의문~(2km)숙정문~(200m)말바위안내소~(1.3km)와룡공원~(1.215km)혜화문",
  trailDifficulty:"어려움",
  trailDistanceDetail:4.715,
  trailLeadTime:"2시간",
  trailDrinkingWaterInfo: "창의문안내소 앞",
  trailToiletInfo:"경복궁역, 창의문안내소, 말바위안내소, 혜화문역",
  trailCafeteriaInfo:"",
  trailKakaoMapImgUrl:"https://storage.googleapis.com/sapoon-promenade-img/0093_01.jpg",
  trailUrl2:"https://storage.googleapis.com/sapoon-promenade-img/0093_02.jpg",
  trailUrl3:"https://storage.googleapis.com/sapoon-promenade-img/0093_03.jpg",
  trailUrl4:"https://storage.googleapis.com/sapoon-promenade-img/0093_04.jpg",
  latitude: 37.594061,
  longitude: 126.99562,
  trailNameshort: "01코스 북악산",
  ),
  Post(
    seq: 106,
    trailUrl: "https://storage.googleapis.com/sapoon-promenade-img/0106_02.jpg",
    trailName:  "서울도보관광코스"+ '\n' + "창경궁 ~ 생태코스",
    trailDistance: "1~5Km미만",
    trailBriefContents: "서울 종로구",
    trailShortName: "서울도보관광코스",
    trailDescription: "창경궁에 있는 나무들에 얽혀 있는 역사와 나무의 생태적 특징을 알아보는 코스. 일상의 삶에 지친 현대인들에게 창경궁의 역사와 생태뿐만 아니라 휴식까지 동시에 느낄 수 있는 코스이다.",
    trailCourseDescription: "옥천교 일원 나무들 → 선인문 앞 사도세자 회화나무 →함인정 옆 신갈나무 → 통명전과 버드나무 상자 → 환경전과 대장금 → 자판기 앞 느티나무 → 춘당지 능수버들 → 춘당지 백송",
    trailDifficulty:"보통",
    trailDistanceDetail:2,
    trailLeadTime:"2시간",
    trailDrinkingWaterInfo: "사전에 준비 필요",
    trailToiletInfo:"창경궁",
    trailCafeteriaInfo:"창경궁 맞은편",
    trailKakaoMapImgUrl:"https://storage.googleapis.com/sapoon-promenade-img/0106_01.jpg",
    trailUrl2:"https://storage.googleapis.com/sapoon-promenade-img/0106_02.jpg",
    trailUrl3:"https://storage.googleapis.com/sapoon-promenade-img/0106_03.jpg",
    trailUrl4:"https://storage.googleapis.com/sapoon-promenade-img/0106_04.jpg",
    latitude: 37.576381,
    longitude: 126.986328,
    trailNameshort: "창경궁 ~ 생태코스",
  ),
  Post(
    seq: 58,
    trailUrl: "https://storage.googleapis.com/sapoon-promenade-img/0058_02.jpg",
    trailName:  "부암동 나들길"+ '\n' + "부암동 나들길",
    trailDistance: "1~5Km미만",
    trailBriefContents: "서울 종로구",
    trailShortName: "부암동 나들길",
    trailDescription: "창의문에서 시작하여 산행 후 창의문으로 되돌아오는 산행의 , 약이 혼재하는 원점회귀 코스다. 좁은 골목길로 안평대군 별장, 현진건 집터를 살펴본 후 인왕산 서북능선을 향해 걷다보면 기차바위 정상에 이른다. 기차바위에서는 폭1.5m 길이50m의 구간을 마치 기차 등을 탄 것 같은 기분으로 통과하게 된다. 복원된 성곽길로 만수천 약수터와 새로 단장한 1.8km의 목재 데크 계단, 버드나무체육시설을 가로지르면 청운공원과 목적지인 창의문에 이르게 된다.",
    trailCourseDescription: "부암동 주민센터~기차바위~만수천약수터~해맞이동산~청운공원",
    trailDifficulty:"보통",
    trailDistanceDetail:2,
    trailLeadTime:"2시간",
    trailDrinkingWaterInfo: "청운공원, 만수천약수터",
    trailToiletInfo:"청운공원(자하문출발점)",
    trailCafeteriaInfo:"부암동주민센터 주변",
    trailKakaoMapImgUrl:"https://storage.googleapis.com/sapoon-promenade-img/0058_01.jpg",
    trailUrl2:"https://storage.googleapis.com/sapoon-promenade-img/0058_02.jpg",
    trailUrl3:"https://storage.googleapis.com/sapoon-promenade-img/0058_03.jpg",
    trailUrl4:"https://storage.googleapis.com/sapoon-promenade-img/0058_04.jpg",
    latitude: 37.584005,
    longitude: 126.963705,
    trailNameshort: "부암동 나들길",
  ),
  Post(
    seq: 100,
    trailUrl: "https://storage.googleapis.com/sapoon-promenade-img/0100_02.jpg",
    trailName:  "서울도보관광코스"+ '\n' + "낙산성곽",
    trailDistance: "1~5Km미만",
    trailBriefContents: "서울 종로구",
    trailShortName: "서울도보관광코스",
    trailDescription: "서울의 몽마르뜨르’라 불리는 낙산공원 및 성곽은 연인들의 데이트장소나 각종 영화, 드라마 촬영지 등으로 각광받고 있는 곳으로, 동대문부터 낙산까지 이어지는 성곽 탐방로를 따라 서울을 한눈에 볼 수 있는 낙산공원 전망대에 오르고, 초대 대통령 내외의 사저였던 이화장까지 관람하는 코스입니다. 아름다운 자연경관 감상은 물론 곳곳에 얽혀있는 역사에 대한 이야기도 들을 수 있습니다",
    trailCourseDescription: "동대문역-흥인지문(동대문)-한양도성-비우당(자주동샘)-낙산공원(전망대)-낙산전시관-이화장",
    trailDifficulty:"쉬움",
    trailDistanceDetail:2.5,
    trailLeadTime:"1시간 30분",
    trailDrinkingWaterInfo: "사전 준비 필요",
    trailToiletInfo:"낙산성곽 중심부, 한양도성박물관",
    trailCafeteriaInfo:"",
    trailKakaoMapImgUrl:"https://storage.googleapis.com/sapoon-promenade-img/0100_01.jpg",
    trailUrl2:"https://storage.googleapis.com/sapoon-promenade-img/0100_02.jpg",
    trailUrl3:"https://storage.googleapis.com/sapoon-promenade-img/0100_03.jpg",
    trailUrl4:"https://storage.googleapis.com/sapoon-promenade-img/0100_04.jpg",
    latitude: 37.572321,
    longitude: 127.009314,
    trailNameshort: "낙산성곽",
  ),

];