import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popup_menu/popup_menu.dart';

import 'iconCard.dart';

_ImageAndIconEditState pageState;

class ImageAndIconEdit extends StatefulWidget {
  const ImageAndIconEdit({Key key, @required this.image, @required this.size})
      : super(key: key);

  final Size size;
  final String image;

  @override
  _ImageAndIconEditState createState() {
    pageState = _ImageAndIconEditState();
    return pageState;
  }
}

class _ImageAndIconEditState extends State<ImageAndIconEdit> {
  File _image;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    menu = PopupMenu(items: [
      MenuItem(
          title: 'Mail',
          image: Icon(
            Icons.mail,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Power',
          image: Icon(
            Icons.power,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Setting',
          image: Icon(
            Icons.settings,
            color: Colors.white,
          )),
      MenuItem(
          title: 'PopupMenu',
          image: Icon(
            Icons.menu,
            color: Colors.white,
          ))
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SizedBox(
        height: widget.size.height * 0.6,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    IconCard(
                      icon: "assets/icons/sun.svg",
                      sizeHW: 50,
                      iconName: '관리 점수',
                    ),
                    IconCard(
                      icon: "assets/icons/icon_2.svg",
                      sizeHW: 50,
                      iconName: '체력 소모 정도',
                    ),
                    IconCard(
                      icon: "assets/icons/icon_3.svg",
                      sizeHW: 50,
                      iconName: '전망 점수',
                    ),
                    IconCard(
                      icon: "assets/icons/icon_4.svg",
                      sizeHW: 50,
                      iconName: '추천 동행자',
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: widget.size.height * 0.51,
                  width: widget.size.width * 0.75,
                  child:
                      (_image != null) ? Image.file(_image) : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.photo, size: 100, color: Colors.white,),
                              Text('사진을 등록해주세요',style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'NanumSquareExtraBold',
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold ),)
                            ],
                          )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(63),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 60,
                        color: Color(0xFF0C9869).withOpacity(0.29),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Gallery"),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                    ),
                    RaisedButton(
                      color: Colors.orange,
                      textColor: Colors.white,
                      child: Text("Camera"),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    print("getImageFromGallery");
    var image = await ImagePicker().getImage(source: source);

    setState(() {
      _image = File(image.path);
    });
  }
}



void onClickMenu(MenuItemProvider item) {
  print('Click menu -> ${item.menuTitle}');
}

void onDismiss() {
  print('Menu is dismiss');
}
