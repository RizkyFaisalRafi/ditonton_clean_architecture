import 'package:ditonton_clean_architecture/data/models/tv_series/created_by_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/episode_to_air_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/production_companies_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/season_model.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';
import '../genre_model.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<CreatedByModel>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final EpisodeToAirModel? lastEpisodeToAir;
  final String? name;
  final EpisodeToAirModel? nextEpisodeToAir;
  final List<ProductionCompaniesModel>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompaniesModel>? productionCompanies;
  final List<SeasonModel>? seasons;
  final String? status;
  final String? tagline;
  final double? voteAverage;
  final int? voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy:
            json["created_by"] == null
                ? []
                : List<CreatedByModel>.from(
                  json["created_by"]!.map((x) => CreatedByModel.fromMap(x)),
                ),
        episodeRunTime:
            json["episode_run_time"] == null
                ? []
                : List<int>.from(json["episode_run_time"]!.map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres:
            json["genres"] == null
                ? []
                : List<GenreModel>.from(
                  json["genres"]!.map((x) => GenreModel.fromJson(x)),
                ),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages:
            json["languages"] == null
                ? []
                : List<String>.from(json["languages"]!.map((x) => x)),
        lastAirDate: json["last_air_date"],
        lastEpisodeToAir:
            json["last_episode_to_air"] == null
                ? null
                : EpisodeToAirModel.fromJson(json["last_episode_to_air"]),
        name: json["name"],

        nextEpisodeToAir:
            json["next_episode_to_air"] == null
                ? null
                : EpisodeToAirModel.fromJson(json["next_episode_to_air"]),
        networks:
            json["networks"] == null
                ? []
                : List<ProductionCompaniesModel>.from(
                  json["networks"]!.map(
                    (x) => ProductionCompaniesModel.fromJson(x),
                  ),
                ),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry:
            json["origin_country"] == null
                ? []
                : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies:
            json["production_companies"] == null
                ? []
                : List<ProductionCompaniesModel>.from(
                  json["production_companies"]!.map(
                    (x) => ProductionCompaniesModel.fromJson(x),
                  ),
                ),
        seasons:
            json["seasons"] == null
                ? []
                : List<SeasonModel>.from(
                  json["seasons"]!.map((x) => SeasonModel.fromJson(x)),
                ),
        status: json["status"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by":
        createdBy == null
            ? []
            : List<dynamic>.from(createdBy!.map((x) => x.toMap())),
    "episode_run_time":
        episodeRunTime == null
            ? []
            : List<dynamic>.from(episodeRunTime!.map((x) => x)),
    "first_air_date": firstAirDate,
    "genres":
        genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages":
        languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "last_air_date": lastAirDate,
    "last_episode_to_air": lastEpisodeToAir?.toJson(),
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "networks":
        networks == null
            ? []
            : List<dynamic>.from(networks!.map((x) => x.toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country":
        originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies":
        productionCompanies == null
            ? []
            : List<dynamic>.from(productionCompanies!.map((x) => x.toJson())),
    "seasons":
        seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvDetail toEntity() {
    return TvDetail(
      adult: adult,
      backdropPath: backdropPath,
      createdBy: createdBy?.map((createdBy) => createdBy.toEntity()).toList(),
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: this.genres?.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies:
          productionCompanies?.map((e) => e.toEntity()).toList(),
      seasons: seasons!.map((season) => season.toEntity()).toList(),
      status: status,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
    languages,
    lastAirDate,
    lastEpisodeToAir,
    name,
    nextEpisodeToAir,
    networks,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    seasons,
    status,
    tagline,
    voteAverage,
    voteCount,
  ];
}
