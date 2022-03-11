import 'package:flutter/material.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {

 final MovieVO? movie;

  BannerView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: BannerImageView(
              imageUrl: movie?.posterPath ?? "",
            ),
        ),

        Positioned.fill(
            child: GradientView(),
        ),

        Align(
          alignment: Alignment.bottomLeft,
            child: BannerTitleView(
              title: movie?.title ?? "",
            ),
        ),

        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        ),
      ],

    );
  }
}


class BannerTitleView extends StatelessWidget {

  final String title;

  BannerTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),),

          Text("Offical Review",style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {

  final String imageUrl;

  BannerImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
    fit: BoxFit.cover,
    );
  }
}


//https://m.media-amazon.com/images/M/MV5BNzg1MDQxMTQ2OF5BMl5BanBnXkFtZTcwMTk3MjAzOQ@@._V1_FMjpg_UX1000_.jpg