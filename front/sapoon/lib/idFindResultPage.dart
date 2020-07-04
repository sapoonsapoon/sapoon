import 'package:flutter/material.dart';
import 'package:sapoon/LoginPage/SignUpPage.dart';
import 'package:sapoon/idFindPage.dart';

class IdFindResultPage extends StatefulWidget {
  final String idVlaue;
  const IdFindResultPage(this.idVlaue);
  @override
  _IdFindResultPageState createState() => _IdFindResultPageState();
}

class _IdFindResultPageState extends State<IdFindResultPage> {
  String show_log='생일을 입력해주세요';
  String dropdownValue = '    남자';

  void _incrementCounter(String value) {
    setState(() {
      show_log =value;
      print(show_log);
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text('아이디 찾기 결과', textAlign: TextAlign.right,),

        ),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(

            child: SafeArea(
              child:  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.all(50.0),
                      ),
                      Text(
                        '아이디 찾기',
                        style: TextStyle(
                            fontFamily: "NanumSquareRegular",
                            fontSize: 40.0,
                            fontWeight: FontWeight.normal,
                          color: Colors.black54,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.width * 0.372,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                              "고객님의 아이디는 \n\n"
                                  "${widget.idVlaue} 입니다",
                            style: TextStyle(
                              fontFamily: "NanumSquareExtraBold",
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.black54,
                            ),textAlign: TextAlign.center,
                      ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      InkWell(
                        onTap: () {
                          final snackbar = SnackBar(content: Text('계정이 없습니다.'));
                          Scaffold.of(context).showSnackBar(snackbar);

                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>SignUpPage()
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.372,
                                height: MediaQuery.of(context).size.width * 0.125,
                                child: Center(
                                  child: Text(
                                    "회원가입",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>IdFindPage()
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.372,
                                height: MediaQuery.of(context).size.width * 0.125,
                                child: Center(
                                  child: Text(
                                    "아이디 찾기",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }));
  }
}

InputDecoration getTextFieldDecor(String hint) {

  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black45),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA3C0F1),
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA3C0F1),
        width: 1,
      ),
    ),
    fillColor: Colors.transparent,
    filled: true,
  );
}


BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}