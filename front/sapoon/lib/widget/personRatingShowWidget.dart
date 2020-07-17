import 'package:flutter/material.dart';
import 'package:sapoon/widget/showDialogTimeWidget.dart';

class PersonRatingShow extends StatelessWidget {
  const PersonRatingShow({
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
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$title\n",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: 'NanumSquareExtraBold',
                        ),
                      ),
                      TextSpan(
                        text: country,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF0C9869),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Text(
                "$price"+"점",
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
                _buildRatingStars(rating),
                Container(
                  padding: EdgeInsets.all(1.0),
                  width: 150.0,
                  alignment: Alignment.centerRight,
                  child: Text(
                    startTime +' ~ ' +endTime,
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
  return Text("추천 점수 : "+stars);
}

