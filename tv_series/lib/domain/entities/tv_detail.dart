import 'episode_to_air.dart';
import 'production_companies.dart';
import 'season.dart';
import 'package:equatable/equatable.dart';
import 'genre.dart';
import 'created_by.dart';

class TvDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final String? lastAirDate;
  final EpisodeToAir? lastEpisodeToAir;
  final String? name;
  final EpisodeToAir? nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<Season>? seasons;
  final String? status;
  final double? voteAverage;
  final int? voteCount;

  const TvDetail({
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

  const TvDetail.watchlist({
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
  }) : adult = null,
       episodeRunTime = null,
       firstAirDate = null,
       homepage = null,
       inProduction = null,
       lastAirDate = null,
       numberOfEpisodes = null,
       numberOfSeasons = null,
       productionCompanies = null,
       status = null,
       voteCount = null;

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
