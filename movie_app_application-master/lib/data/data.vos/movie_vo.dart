import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/data.vos/collection_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/production_company_vo.dart';
import 'package:movie_app/data/data.vos/production_country_vo.dart';
import 'package:movie_app/data/data.vos/spoken_language_vo.dart';
import 'package:movie_app/persistance/hive_constants.dart';

part 'movie_vo.g.dart';

///MovieVO is used in now playing,popular,top rated,get movies by genre.
///MovieVO is used in movie_details.Also used as return type.

///MovieVO is used in BestPopularMoviesAndSerials,ShowCase,BannerSection.
///To store in Hive,use bool type var for each section.

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backDropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(7)
  String? overView;

  @JsonKey(name: "popularity")
  @HiveField(8)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(9)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(10)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(11)
  String? title;

  @JsonKey(name: "video")
  @HiveField(12)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(13)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(14)
  int? voteCount;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(15)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(16)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(17)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(18)
  String? homePage;

  @JsonKey(name: "imdb_id")
  @HiveField(19)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(20)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(21)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "revenue")
  @HiveField(22)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(23)
  int? runTime;

  @JsonKey(name: "spoken_languages")
  @HiveField(24)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(25)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(26)
  String? tagLine;

  @HiveField(27)
  bool? isNowPlaying;

  @HiveField(28)
  bool? isPopular;

  @HiveField(29)
  bool? isTopRated;

  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overView,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.imdbId,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runTime,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.isNowPlaying,
      this.isPopular,
      this.isTopRated);

  //json to object
  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFormJson(json);

  //object to json
  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  String getRuntimeString(int runTime) {
    late String hour;
    late String minute;

    hour = (runTime / 60).toStringAsFixed(0);
    minute = (runTime % 60).toString();

    return "${hour}hr ${minute}min";
  }

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  String getGenreListAsCommaSeparatedString() {
    return genres?.map((genre) => genre.name ?? "").toList().join(",") ?? "";
  }

  String getProductionCountriesAsCommaSeparatedString() {
    return productionCountries
            ?.map((country) => country.name ?? "")
            .toList()
            .join(",") ??
        "";
  }

  //VO mr pr tat properties twy a twt string t ku return pyn
  //null,value mhr,data pr ll kyi lox ya
  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overView: $overView, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}
