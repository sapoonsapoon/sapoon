import 'package:flutter/material.dart';
class PersonRatingEdit extends StatefulWidget {
  const PersonRatingEdit({
    Key key,
    this.title,
    this.country,
    this.price,
    this.rating,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  final String title, country, startTime, endTime;
  final int price, rating;

  @override
  _PersonRatingEditState createState() => _PersonRatingEditState();
}

class _PersonRatingEditState extends State<PersonRatingEdit> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height* 0.10,
                width: MediaQuery.of(context).size.width*0.6,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _controller,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: '한줄평을 적어주세요',
                          labelStyle: TextStyle(color: Colors.blue),
                        )
                    )
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${widget.price}"+"점",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Color(0xFF0C9869)),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height* 0.03,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildRatingStars(widget.rating),
                Container(
                  padding: EdgeInsets.all(1.0),
                  width: 150.0,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.startTime +' ~ ' +widget.endTime,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Text _buildRatingStars(int rating) {
  String stars = '';
  for (int i = 0; i < rating; i++) {
    stars += '⭐ ';
  }
  stars.trim();
  return Text("주간: "+stars);
}


