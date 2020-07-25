import 'package:flutter/material.dart';

class RegionProvider with ChangeNotifier {

  String _region="강남구";

  //현재 페이지를 받아오고 해당 인덱스를 수정하는 setter
  void setCurrentIndex(String currentRegion) {
    _region = currentRegion;
    notifyListeners();
  }

  //현재 인덱스를 반환하는 getter
  String currentRegion() => _region;
}
