import 'package:ditonton_clean_architecture/domain/entities/tv/episode_to_air.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/production_companies.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/season.dart';
import 'package:equatable/equatable.dart';
import '../genre.dart';
import 'created_by.dart';

class TvDetail extends Equatable {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  String? lastAirDate;
  EpisodeToAir? lastEpisodeToAir;
  String? name;
  EpisodeToAir? nextEpisodeToAir;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<Season>? seasons;
  String? status;
  double? voteAverage;
  int? voteCount;

  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.seasons,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  TvDetail.watchlist({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.popularity,
    required this.createdBy,
    required this.seasons,
    required this.lastEpisodeToAir,
    required this.nextEpisodeToAir,
});

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    createdBy,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    seasons,
    status,
    voteAverage,
    voteCount,
  ];
}
