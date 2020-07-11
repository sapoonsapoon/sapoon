import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popup_menu/popup_menu.dart';

import 'iconCard.dart';

class ImageAndIcons extends StatefulWidget {
  const ImageAndIcons({
    Key key,
    @required this.image,
    @required this.size
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  _ImageAndIconsState createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
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
      padding: const EdgeInsets.only(bottom: 0.0 * 3),
      child: SizedBox(
        height: widget.size.height * 0.65,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0),
                        icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Spacer(),
                    IconCard(
                      icon: "assets/icons/sun.svg",
                      sizeHW: 54,
                    ),
                    IconCard(icon: "assets/icons/icon_2.svg",
                      sizeHW: 54,),
                    IconCard(icon: "assets/icons/icon_3.svg",
                      sizeHW: 54,),
                    IconCard(icon: "assets/icons/icon_4.svg",
                      sizeHW: 54,),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      return ImageDetailHome(widget.image);
                    }));
              },
              child: Hero(
                tag: widget.image,
                child: Container(
                  height: widget.size.height * 0.8,
                  width: widget.size.width * 0.75,
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
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(widget.image),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDetailHome extends StatelessWidget {
  final String imageUrl;

  ImageDetailHome(this.imageUrl); // 생성자를 통해 imageUrl 을 전달받음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.6,
            child: Hero(tag: imageUrl, child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            )),
          ),
        ),
      ),
    );
  }
}
void onClickMenu(MenuItemProvider item) {
  print('Click menu -> ${item.menuTitle}');
}

void onDismiss() {
  print('Menu is dismiss');
}
