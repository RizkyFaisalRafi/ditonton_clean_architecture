import 'package:equatable/equatable.dart';
import 'package:tv_series/module/tv_series.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
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

  const MovieDetail.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.runtime,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  }) : adult = null,
       backdropPath = null,
       originalTitle = null,
       voteCount = null;

  final bool? adult;
  final String? backdropPath;
  final List<Genre>? genres;
  final int id;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final int? runtime;
  final String? title;
  final double? voteAverage;
  final int? voteCount;

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
