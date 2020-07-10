import 'package:flutter/material.dart';

class PersonRating extends StatelessWidget {
  const PersonRating({
    Key key,
    this.title,
    this.country,
    this.price,
  }) : super(key: key);

  final String title, country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height* 0.15,
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
            "$price",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Color(0xFF0C9869)),
          )
        ],
      ),
    );
  }
}
