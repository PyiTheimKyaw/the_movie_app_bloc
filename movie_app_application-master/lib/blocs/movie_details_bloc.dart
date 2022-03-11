import 'dart:async';

import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../data/data.vos/movie_vo.dart';

class MovieDetailsBloc {
  StreamController<MovieVO?> movieStreamController = StreamController();
  StreamController<List<ActorVO>?> castStreamController = StreamController();
  StreamController<List<ActorVO>?> crewStreamController = StreamController();

  ///Models
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    ///MovieDetails
    mMovieModel.getMovieDetails(movieId).then((movieDetails) {
      movieStreamController.sink.add(movieDetails);
    }).catchError((error) {});

    ///Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movieDetails) {
      movieStreamController.sink.add(movieDetails);
    }).catchError((error) {});

    ///CreditsByMovie
    mMovieModel.getCreditsByMovie(movieId).then((castAndCrew) {
      castStreamController.sink.add(castAndCrew.first);
      crewStreamController.sink.add(castAndCrew[1]);
    }).catchError((error) {});
  }

  void disposeStream() {
    movieStreamController.close();
    castStreamController.close();
    crewStreamController.close();
  }
}
