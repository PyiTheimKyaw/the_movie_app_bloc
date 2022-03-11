import 'dart:async';
import 'dart:math';

import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

class HomeBloc {
  ///Reactive Streams
   StreamController<List<MovieVO>> mNowPlayingStreamController =
      StreamController();
   StreamController<List<MovieVO>> mPopularMoviesListStreamController =
      StreamController();
   StreamController<List<GenreVO>?> mGenreListStreamController =
      StreamController();
   StreamController<List<ActorVO>?> mActorsStreamController =
      StreamController();
   StreamController<List<MovieVO>> mTopRatedMoviesListStreamController =
      StreamController();
   StreamController<List<MovieVO>?> mMoviesByGenreListStreamController =
      StreamController();

  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    ///Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingStreamController.sink.add(movieList);
    }).onError((error) {});

    ///Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesListStreamController.sink.add(movieList);
    }).onError((error) {});

    ///TopRated Movies Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mTopRatedMoviesListStreamController.sink.add(movieList);
    }).onError((error) {});

    ///Genres
    mMovieModel.getGenres().then((genreList) {
      mGenreListStreamController.sink.add(genreList);

      ///Movies By Genre
      getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {});

    ///Genres Database
    mMovieModel.getGenresFromDatabase().then((genres) {
      mGenreListStreamController.sink.add(genres);

      ///Movies By Genre Database
      getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
    }).catchError((error) {});

    ///Actors
    mMovieModel.getActors(1).then((actors) {
      mActorsStreamController.sink.add(actors);
    }).catchError((error) {});

    ///Actors Database
    mMovieModel.getActorsFromDatabase().then((actors) {
      mActorsStreamController.sink.add(actors);
    }).catchError((error) {});
  }

  void dispose() {
    mNowPlayingStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mTopRatedMoviesListStreamController.close();
    mMoviesByGenreListStreamController.close();
  }

  void onTapGenre(int genreId){
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      mMoviesByGenreListStreamController.sink.add(moviesByGenre);
    }).catchError((error) {});
  }
}
