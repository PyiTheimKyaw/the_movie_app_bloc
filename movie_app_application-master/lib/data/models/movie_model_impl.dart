import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/network/dataagents/movie_data_agents.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agents_impl.dart';
import 'package:movie_app/persistance/daos/actor_dao.dart';
import 'package:movie_app/persistance/daos/genre_dao.dart';
import 'package:movie_app/persistance/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel{

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  ///Dao
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();


  ///Network
  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies){
        List<MovieVO> nowPlayingMovies = movies?.map((movie){
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(nowPlayingMovies);
       //return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(1).then((actors){
      mActorDao.saveAllActors(actors ?? []);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) {
        mGenreDao.saveAllGenres(genres ?? []);
        return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  void getPopularMovies(int page) {
     _dataAgent.getPopularMovies(page).then((movies){
      List<MovieVO> popularMovies = movies?.map((movie){
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;
          return movie;
      }).toList() ?? [];
      mMovieDao.saveMovies(popularMovies);
      //return Future.value(movies);
    });
  }

  @override
  void getTopRatedMovies(int page) {
   _dataAgent.getTopRatedMovies(page).then((movies){
        List<MovieVO> topRatedMovies = movies?.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(topRatedMovies);
       // return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
      return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
      return _dataAgent.getMovieDetails(movieId).then((movie){
          mMovieDao.saveSingleMovie(movie!);
          return Future.value(movie);
      });
  }

  ///Database
  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
      return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    // return Future.value(
    //   mMovieDao.getAllMovies()
    //       .where((movies) {
    //         return movies.isNowPlaying ?? true;
    //   }).toList());
      this.getNowPlayingMovies(1);
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getNowPlayingMoviesStream())
      .map((event) => mMovieDao.getNowPlayingMovies(),);
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
      // return Future.value(
      //     mMovieDao.getAllMovies()
      //         .where((movies) => movies.isPopular ?? true )
      //         .toList());
      this.getPopularMovies(1);
      return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies(),);
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
      // return Future.value(
      //   mMovieDao.getAllMovies()
      //       .where((movies) => movies.isTopRated ?? true )
      //       .toList());
     this.getTopRatedMovies(1);
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getTopRatedMoviesStream())
      .map((event) => mMovieDao.getTopRatedMovies()); 
       
  }

}