// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/date_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/view_items/banner_view.dart';
import 'package:movie_app/view_items/movie_view.dart';
import 'package:movie_app/view_items/showcase_view.dart';
import 'package:movie_app/widgets/actor_view.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ///Model
  // MovieModel movieModel = MovieModelImpl();
  //
  // ///State Variables
  // List<MovieVO>? nowPlayingMovies;
  // List<MovieVO>? popularMovies;
  // List<MovieVO>? topRatedMovies;
  // List<MovieVO>? moviesByGenre;
  // List<GenreVO>? genres;
  // List<ActorVO>? actors;
  HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    // ///Now Playing Movies
    // // movieModel.getNowPlayingMovies().then((movieList) {
    // //   setState(() {
    // //     nowPlayingMovies = movieList;
    // //   });
    // // }).catchError((error) {
    // //   debugPrint(error.toString());
    // // });
    //
    // ///Now Playing Movies Database
    // movieModel.getNowPlayingMoviesFromDatabase().listen((movieList){
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).onError((error){
    //   debugPrint(error.toString());
    // });
    //
    // ///Popular Movies
    // // movieModel.getPopularMovies().then((movieList) {
    // //   setState(() {
    // //     popularMovies = movieList;
    // //   });
    // // }).catchError((error) {
    // //   debugPrint(error.toString());
    // // });
    //
    // ///Popular Movies Database
    // movieModel.getPopularMoviesFromDatabase().listen((movieList){
    //   setState(() {
    //     popularMovies = movieList;
    //   });
    // }).onError((error){
    //   debugPrint(error.toString());
    // });
    //
    // ///Top Rated Movies
    // // movieModel.getNowPlayingMovies().then((movieList) {
    // //   setState(() {
    // //     topRatedMovies = movieList;
    // //   });
    // // }).catchError((error) {
    // //   debugPrint(error.toString());
    // // });
    //
    // ///Top Rated Movies Database
    // movieModel.getTopRatedMoviesFromDatabase().listen((movieList){
    //   setState(() {
    //     topRatedMovies = movieList;
    //   });
    // }).onError((error){
    //   debugPrint(error.toString());
    // });
    //
    // ///Genres
    // movieModel.getGenres().then((genres) {
    //   setState(() {
    //     this.genres = genres;
    //
    //     ///Movies By Genre
    //     _getMoviesByGenre(genres?.first.id ?? 0);
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });
    //
    // ///Genres Database
    // movieModel.getGenresFromDatabase().then((genres){
    //   setState(() {
    //     this.genres = genres;
    //
    //     ///Movies By Genre Database
    //     _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
    //   });
    // }).catchError((error){
    //   debugPrint(error.toString());
    // });
    //
    // ///Actors
    // movieModel.getActors(1).then((actors) {
    //   setState(() {
    //     this.actors = actors;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });
    //
    // ///Actors Database
    // movieModel.getActorsFromDatabase().then((actors){
    //   setState(() {
    //     this.actors = actors;
    //   });
    // }).catchError((error){
    //   debugPrint(error.toString());
    // });

    super.initState();
  }
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();

  }

  // void _getMoviesByGenreAndRefresh(int genreId){
  //   movieModel.getMoviesByGenre(genreId).then((moviesByGenre){
  //     setState(() {
  //       this.moviesByGenre = moviesByGenre;
  //     });
  //   }).catchError((error){
  //     debugPrint(error.toString());
  //   });
  // }
  //
  // void _getMoviesByGenre(int genreId) {
  //   movieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
  //     setState(() {
  //       this.moviesByGenre = moviesByGenre;
  //     });
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //rgb tn phoe nk widget lvl mr yay yin litral lox khw
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Icon(Icons.menu),
        actions: [
          const Padding(
            //padding yk datatype ka double
            padding: const EdgeInsets.only(
                top: 0, left: 0, bottom: 0, right: MARGIN_MEDIUM_2),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: _bloc.mPopularMoviesListStreamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieVO>> snapshot) {
                  return BannerSectionView(
                    movieList: snapshot.data?.take(5).toList() ?? [],
                  );
                },
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder(
                stream: _bloc.mNowPlayingStreamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieVO>> snapshot) {
                  return BestPopularMoviesAndSerialsSectionView(
                    (movieId) => _navigateToMovieDetailScreen(context, movieId),
                    nowPlayingMovies: snapshot.data,
                  );
                },
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              CheckMovieShowTimeSectionView(),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder(
                stream: _bloc.mGenreListStreamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<GenreVO>?> genreSnapShot) {
                  return StreamBuilder(
                    stream: _bloc.mMoviesByGenreListStreamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MovieVO>?> movieByGenreSnapShot) {
                      return GenreSectionView(
                        genreList: genreSnapShot.data,
                        moviesByGenre: movieByGenreSnapShot.data,
                        onTapMovie: (movieId) =>
                            _navigateToMovieDetailScreen(context, movieId),
                        onChooseGenre: (genreId) {
                          if (genreId != null) {
                            _bloc.onTapGenre(genreId);
                          }
                        },
                      );
                    },
                  );
                },

              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder(
                stream: _bloc.mTopRatedMoviesListStreamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieVO>> snapshot) {
                  return ShowCasesSection(
                    topRatedMovies: snapshot.data,
                  );
                },
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              StreamBuilder(
                stream: _bloc.mActorsStreamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ActorVO>?> snapshot) {
                  return ActorsAndCreatorsSectionView(
                    BEST_ACTORS_TITLE,
                    BEST_ACTORS_SEE_MORE,
                    actors: snapshot.data,
                  );
                },
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailPage(
            movieId: movieId,
          ),
        ),
      );
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  GenreSectionView(
      {required this.genreList,
      required this.moviesByGenre,
      required this.onTapMovie,
      required this.onChooseGenre,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList?.map((genre) {
                    return Tab(
                      child: Text(genre.name ?? ""),
                    );
                  }).toList() ??
                  [],
              onTap: (int index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieList: moviesByGenre,
          ),
        ),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? nowPlayingMovies;

  BestPopularMoviesAndSerialsSectionView(this.onTapMovie,
      {required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        SizedBox(
          height: MARGIN_LARGE,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) => this.onTapMovie(movieId),
          movieList: nowPlayingMovies,
        ),
      ],
    );
  }
}

class ShowCasesSection extends StatelessWidget {
  final List<MovieVO>? topRatedMovies;

  ShowCasesSection({required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASE_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: topRatedMovies?.map((topRatedMovies) {
                  return ShowCaseView(movie: topRatedMovies);
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTapMovie(movieList?[index].id),
                  child: MovieView(
                    movie: movieList?[index],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList?.map((movie) {
                  return BannerView(movie: movie);
                }).toList() ??
                [],
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        DotsIndicator(
          dotsCount: (widget.movieList?.length == 0)
              ? 1
              : widget.movieList?.length ?? 1,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}
