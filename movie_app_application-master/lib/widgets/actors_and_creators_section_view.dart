import 'package:flutter/material.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actor_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {

 final String titleText;
 final String seeMoreText;
 final bool seeMoreButtonVisibility;
 final List<ActorVO>? actors;

  ActorsAndCreatorsSectionView(this.titleText,this.seeMoreText,{this.seeMoreButtonVisibility=true,required this.actors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_XXLARGE),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
                titleText,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Container(
            height: BEST_ACTOR_HEIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              // children: [
              //   ActorView(),
              //   ActorView(),
              //   ActorView(),
              // ],
              children: actors?.map((actor){
                return ActorView(actor: actor);
              }).toList() ?? [],
            ),
          ),
        ],
      ),
    );
  }
}