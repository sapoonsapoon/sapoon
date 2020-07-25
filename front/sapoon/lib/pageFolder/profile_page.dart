import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sapoon/widget/profile_side_menu.dart';
import 'package:sapoon/widget/size.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  bool _menuOpened = false;
  double menuWidth;
  int duration = 300;
  AlignmentGeometry tabAlign = Alignment.centerLeft;
  bool _tabIconGridSelected = true;
  double _gridMargin = 0;
  double _myImgGridMargin = size.width;

  String _nickName = Hive.box('image').get('nickname');
  String _photoUrl = Hive.box('image').get('profilePhoto');
  String _sapoon = Hive.box('image').get('loginWithSapoon');

  @override
  void initState() {
    if(_sapoon == '1'){
      _photoUrl='https://picsum.photos/200/300';
    }
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: duration));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    menuWidth = size.width / 1.5;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          _sideMenu(),
          _profile(),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      width: menuWidth,
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(
        _menuOpened ? size.width - menuWidth : size.width,
        0,
        0,
      ),
      child: SafeArea(
        child: SizedBox(
          width: menuWidth,
          child: ProfileSideMenu(),
        ),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInOut,
      color: Colors.transparent,
      transform: Matrix4.translationValues(
        _menuOpened ? -menuWidth : 0,
        0,
        0,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildListDelegate([
                    _getProfileHeader,
                    _username(),
                    _userBio(),
                    _getTabIconButtons,
                    _getAnimatedSelectedBar,
                      ])),
                  _getImageGrid(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  SliverToBoxAdapter _getImageGrid(BuildContext context) => SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            transform: Matrix4.translationValues(_gridMargin, 0, 0),
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut,
            child: _imageGrid,
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(_myImgGridMargin, 0, 0),
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut,
            child: _imageGrid,
          )
        ],
      )
  );

  GridView get _imageGrid => GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(30, (index) => _gridImgItem(index)
      ),
    );

  CachedNetworkImage _gridImgItem(int index) => CachedNetworkImage(

          fit: BoxFit.cover,
          imageUrl: "https://picsum.photos/id/1$index/200/200");

  Padding _editProfileBtn() {
    return Padding(
                      padding: const EdgeInsets.all(common_gap),
                      child: SizedBox(
                        height: 24,
                        child: OutlineButton(
                            onPressed: () {},
                            borderSide: BorderSide(color: Colors.black45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ));
  }

  Padding _userBio() {
    return Padding(
                    padding: const EdgeInsets.only(left: common_gap),
                    child: Text(
                      '개미는 뚠뚠 열심히 일한다 뚠뚠',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  );
  }

  Padding _username() {
    return Padding(
                    padding: const EdgeInsets.only(left: common_gap),
                    child: Text(
                      _nickName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
  }

  Row get _getProfileHeader => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://picsum.photos/seed/picsum/200/300'),
            ),
          ),
          Expanded(
            child: Table(
              children: [
                TableRow(children: [
                  _getStatusValueWidget('33'),
                  _getStatusValueWidget('635'),
                  _getStatusValueWidget('632'),
                ]),
                TableRow(children: [
                  _getStatusLabelWidget('Posts'),
                  _getStatusLabelWidget('Followers'),
                  _getStatusLabelWidget('Following'),
                ]),
              ],
            ),
          )
        ],
      );

  Widget _getStatusValueWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
      );

  Widget _getStatusLabelWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300),
              )),
        ),
      );

  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text(
            'Setting',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            semanticLabel: 'Show menu',
          ),
          onPressed: () {
            _menuOpened ? _animationController.reverse() : _animationController.forward();
            setState(() {
              _menuOpened = !_menuOpened;
            });
          },
        )
      ],
    );
  }


  Widget get _getTabIconButtons => Row(
    children: <Widget>[
      Expanded(
        child: IconButton(
            icon: ImageIcon(AssetImage("assets/grid.png"), color: _tabIconGridSelected?Colors.black:Colors.black26,),
            onPressed: () {
              _setTab(true);
            }),
      ),
      Expanded(
          child: IconButton(
              icon: ImageIcon(AssetImage("assets/saved.png"), color: _tabIconGridSelected?Colors.black26:Colors.black,),
              onPressed: () {
                _setTab(false);
              })),
    ],
  );


  Widget get _getAnimatedSelectedBar => AnimatedContainer(
    alignment: tabAlign,
    duration: Duration(milliseconds: duration),
    curve: Curves.easeInOut,
    color: Colors.transparent,
    height: 1,
    width: size.width,
    child: Container(
      height: 1,
      width: size.width / 2,
      color: Colors.black87,
    ),
  );

  _setTab(bool tabLeft) {
    setState(() {
      if (tabLeft) {
        this.tabAlign = Alignment.centerLeft;
        this._tabIconGridSelected = true;
        this._gridMargin = 0;
        this._myImgGridMargin = size.width;

      } else {
        this.tabAlign = Alignment.centerRight;
        this._tabIconGridSelected = false;
        this._gridMargin = -size.width;
        this._myImgGridMargin = 0;
      }
    });
  }

}
