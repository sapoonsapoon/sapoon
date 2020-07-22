import 'package:flutter/material.dart';
import 'package:sapoon/LoginPage/LoginPage.dart';

class PasswordFindResultPage extends StatefulWidget {
  @override
  _PasswordFindResultPageState createState() => _PasswordFindResultPageState();
}

class _PasswordFindResultPageState extends State<PasswordFindResultPage> {
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
          title: Text('비밀번호 찾기', textAlign: TextAlign.right,),

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
                        '비밀번호 찾기',
                        style: TextStyle(
                            fontFamily: "NanumSquareRegular",
                            fontSize: 40.0,
                            fontWeight: FontWeight.normal,
                          color: Colors.black54),
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
                            "고객님의 새로운 비밀번호를 \n\n"
                                "고객님의 이메일로 전송하였습니다.",
                            style: TextStyle(
                                fontFamily: "NanumSquareExtraBold",
                                fontWeight: FontWeight.normal,
                                fontSize: 17.0,
                                color: Colors.black54
                            ),textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.744,
                          height: MediaQuery.of(context).size.width * 0.125,
                          child: Center(
                            child: Text(
                              "로그인 하러 가기",
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
