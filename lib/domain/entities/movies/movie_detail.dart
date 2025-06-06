import 'package:ditonton_clean_architecture/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  MovieDetail.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.runtime,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  });

  bool? adult;
  String? backdropPath;
  List<Genre>? genres;
  int id;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  int? runtime;
  String? title;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    originalTitle,
    overview,
    posterPath,
    releaseDate,
    title,
    voteAverage,
    voteCount,
  ];
}
