import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Brand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Brands'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("Auntie Lydia's"), //${brandName}
              subtitle: const Text("Crochet Thread"), //${threadType}
              trailing: RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const FaIcon(
                    FontAwesomeIcons.solidStar,
                    size: 0.5,
                  ),
                  half: const FaIcon(
                    FontAwesomeIcons.solidStarHalf,
                    size: 0.5,
                  ),
                  empty: const FaIcon(
                    FontAwesomeIcons.star,
                    size: 0.5,
                  ),
                ),
                //itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class BrandRating extends StatelessWidget {
  const BrandRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
