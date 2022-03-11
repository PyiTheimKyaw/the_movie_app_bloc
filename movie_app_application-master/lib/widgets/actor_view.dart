import 'package:flutter/material.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {

  final ActorVO? actor;

  ActorView({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
              child: ActorImageView(
                actorProfilePath: actor?.profilePath ?? "",
              ),
          ),

          Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ActorNameAndLikeView(
              actorName: actor?.name ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {

  final String actorProfilePath;

  ActorImageView({required this.actorProfilePath});

  @override
  Widget build(BuildContext context) {
    return Image.network("$IMAGE_BASE_URL${actorProfilePath}",
    fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.favorite_border,color: Colors.white,);
  }
}

class ActorNameAndLikeView extends StatelessWidget {

  final String actorName;

  ActorNameAndLikeView({required this.actorName});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(actorName,style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR,
          ),),
          SizedBox(height: MARGIN_MEDIUM,),
          Row(
            children: [
            Icon(Icons.thumb_up,color: Colors.amber,size: MARGIN_CARD_MEDIUM_2,),
             SizedBox(width: MARGIN_MEDIUM,),
           Text("YOU LIKED 13 MOVIES",style: TextStyle(
                color: HOME_SCREEN_LIST_TITLE_COLOR,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
