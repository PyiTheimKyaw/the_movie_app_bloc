import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/resources/dimens.dart';

class RatingView extends StatelessWidget {

  final double movieRate;

  RatingView({required this.movieRate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: movieRate/2,
        allowHalfRating: true,
        ignoreGestures: true,
        itemBuilder: (BuildContext context,int index){
          return Icon(Icons.star,color: Colors.amber,);
        },
        itemSize: MARGIN_MEDIUM_2,
        onRatingUpdate: (rating){
          rating;
        },
      );
  }
}
