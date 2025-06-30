import 'dart:convert';
import '../../../module/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailTable extends Equatable {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;
  final String? overview;
  final double? voteAverage;
  final String? genres;
  final double? popularity;
  final String? createdBy;
  final String? seasons;
  final String? lastEpisodeToAir;
  final String? nextEpisodeToAir;

  TvSeriesDetailTable({
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

  factory TvSeriesDetailTable.fromEntity(TvDetail tvDetail) =>
      TvSeriesDetailTable(
        id: tvDetail.id,
        name: tvDetail.name,
        posterPath: tvDetail.posterPath,
        backdropPath: tvDetail.backdropPath,
        overview: tvDetail.overview,
        voteAverage: tvDetail.voteAverage,

        genres: jsonEncode(
          tvDetail.genres?.map((g) => {'id': g.id, 'name': g.name}).toList(),
        ),
        popularity: tvDetail.popularity,

        createdBy: jsonEncode(
          tvDetail.createdBy?.map((g) {
            return {
              'id': g.id,
              'credit_id': g.creditId,
              'name': g.name,
              'original_name': g.originalName,
              'gender': g.gender,
              'profile_path': g.profilePath,
            };
          }).toList(),
        ),

        seasons: jsonEncode(
          tvDetail.seasons?.map((g) {
            return {
              'air_date': g.airDate,
              'episode_count': g.episodeCount,
              'id': g.id,
              'name': g.name,
              'overview': g.overview,
              'poster_path': g.posterPath,
              'season_number': g.seasonNumber,
              'vote_average': g.voteAverage,
            };
          }).toList(),
        ),

        lastEpisodeToAir: jsonEncode(
          tvDetail.lastEpisodeToAir != null
              ? {
                'id': tvDetail.lastEpisodeToAir!.id,
                'name': tvDetail.lastEpisodeToAir!.name,
                'overview': tvDetail.lastEpisodeToAir!.overview,
                'vote_average': tvDetail.lastEpisodeToAir!.voteAverage,
                'vote_count': tvDetail.lastEpisodeToAir!.voteCount,
                'air_date': tvDetail.lastEpisodeToAir!.airDate,
                'episode_number': tvDetail.lastEpisodeToAir!.episodeNumber,
                'episode_type': tvDetail.lastEpisodeToAir!.episodeType,
                'production_code': tvDetail.lastEpisodeToAir!.productionCode,
                'runtime': tvDetail.lastEpisodeToAir!.runtime,
                'season_number': tvDetail.lastEpisodeToAir!.seasonNumber,
                'show_id': tvDetail.lastEpisodeToAir!.showId,
                'still_path': tvDetail.lastEpisodeToAir!.stillPath,
              }
              : null,
        ),

        nextEpisodeToAir: jsonEncode(
          tvDetail.nextEpisodeToAir != null
              ? {
                'id': tvDetail.nextEpisodeToAir!.id,
                'name': tvDetail.nextEpisodeToAir!.name,
                'overview': tvDetail.nextEpisodeToAir!.overview,
                'vote_average': tvDetail.nextEpisodeToAir!.voteAverage,
                'vote_count': tvDetail.nextEpisodeToAir!.voteCount,
                'air_date': tvDetail.nextEpisodeToAir!.airDate,
                'episode_number': tvDetail.nextEpisodeToAir!.episodeNumber,
                'episode_type': tvDetail.nextEpisodeToAir!.episodeType,
                'production_code': tvDetail.nextEpisodeToAir!.productionCode,
                'runtime': tvDetail.nextEpisodeToAir!.runtime,
                'season_number': tvDetail.nextEpisodeToAir!.seasonNumber,
                'show_id': tvDetail.nextEpisodeToAir!.showId,
                'still_path': tvDetail.nextEpisodeToAir!.stillPath,
              }
              : null,
        ),
      );

  factory TvSeriesDetailTable.fromMap(Map<String, dynamic> map) =>
      TvSeriesDetailTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        backdropPath: map['backdropPath'],
        overview: map['overview'],
        voteAverage: map['voteAverage']?.toDouble(),
        genres: map['genres'],
        popularity: map['popularity']?.toDouble(),
        createdBy: map['createdBy'],
        seasons: map['seasons'],
        lastEpisodeToAir: map['lastEpisodeToAir'],
        nextEpisodeToAir: map['nextEpisodeToAir'],
      );

  factory TvSeriesDetailTable.fromDetailDTO(TvDetailResponse detail) =>
      TvSeriesDetailTable(
        id: detail.id,
        name: detail.name,
        posterPath: detail.posterPath,
        backdropPath: detail.backdropPath,
        overview: detail.overview,
        voteAverage: detail.voteAverage,
        genres: jsonEncode(
          detail.genres.map((g) => {'id': g.id, 'name': g.name}).toList(),
        ),
        popularity: detail.popularity,

        createdBy: jsonEncode(
          detail.createdBy?.map((g) {
            return {
              'id': g.id,
              'credit_id': g.creditId,
              'name': g.name,
              'original_name': g.originalName,
              'gender': g.gender,
              'profile_path': g.profilePath,
            };
          }).toList(),
        ),
        seasons: jsonEncode(
          detail.seasons?.map((g) {
            return {
              'air_date': g.airDate,
              'episode_count': g.episodeCount,
              'id': g.id,
              'name': g.name,
              'overview': g.overview,
              'poster_path': g.overview,
              'season_number': g.seasonNumber,
              'vote_average': g.voteAverage,
            };
          }).toList(),
        ),
        lastEpisodeToAir: jsonEncode(
          detail.lastEpisodeToAir != null
              ? {
                'id': detail.lastEpisodeToAir?.id,
                'name': detail.lastEpisodeToAir?.name,
                'overview': detail.lastEpisodeToAir?.overview,
                'vote_average': detail.lastEpisodeToAir?.voteAverage,
                'vote_count': detail.lastEpisodeToAir?.voteCount,
                'air_date': detail.lastEpisodeToAir?.airDate,
                'episode_number': detail.lastEpisodeToAir?.episodeNumber,
                'episode_type': detail.lastEpisodeToAir?.episodeType,
                'production_code': detail.lastEpisodeToAir?.productionCode,
                'runtime': detail.lastEpisodeToAir?.runtime,
                'season_number': detail.lastEpisodeToAir?.seasonNumber,
                'show_id': detail.lastEpisodeToAir?.showId,
                'still_path': detail.lastEpisodeToAir?.stillPath,
              }
              : null,
        ),
        nextEpisodeToAir: jsonEncode(
          detail.nextEpisodeToAir != null
              ? {
                'id': detail.nextEpisodeToAir?.id,
                'name': detail.nextEpisodeToAir?.name,
                'overview': detail.nextEpisodeToAir?.overview,
                'vote_average': detail.nextEpisodeToAir?.voteAverage,
                'vote_count': detail.nextEpisodeToAir?.voteCount,
                'air_date': detail.nextEpisodeToAir?.airDate,
                'episode_number': detail.nextEpisodeToAir?.episodeNumber,
                'episode_type': detail.nextEpisodeToAir?.episodeType,
                'production_code': detail.nextEpisodeToAir?.productionCode,
                'runtime': detail.nextEpisodeToAir?.runtime,
                'season_number': detail.nextEpisodeToAir?.seasonNumber,
                'show_id': detail.nextEpisodeToAir?.showId,
                'still_path': detail.nextEpisodeToAir?.stillPath,
              }
              : null,
        ),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'backdropPath': backdropPath,
    'overview': overview,
    'voteAverage': voteAverage,
    'genres': genres,
    'popularity': popularity,
    'createdBy': createdBy,
    'seasons': seasons,
    'lastEpisodeToAir': lastEpisodeToAir,
    'nextEpisodeToAir': nextEpisodeToAir,
  };

  TvDetail toEntity() => TvDetail.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    backdropPath: backdropPath,
    overview: overview,
    voteAverage: voteAverage,
    genres:
        genres != null
            ? (jsonDecode(genres!) as List)
                .map((g) => Genre(id: g['id'], name: g['name']))
                .toList()
            : [],
    popularity: popularity,
    createdBy:
        createdBy != null
            ? (jsonDecode(createdBy!) as List)
                .map(
                  (g) => CreatedBy(
                    id: g['id'],
                    creditId: g['credit_id'],
                    name: g['name'],
                    originalName: g['original_name'],
                    gender: g['gender'],
                    profilePath: g['profile_path'],
                  ),
                )
                .toList()
            : [],
    seasons:
        seasons != null
            ? (jsonDecode(seasons!) as List)
                .map(
                  (g) => Season(
                    airDate: g['air_date'],
                    episodeCount: g['episode_count'],
                    id: g['id'],
                    name: g['name'],
                    overview: g['overview'],
                    posterPath: g['poster_path'],
                    seasonNumber: g['season_number'],
                    voteAverage: g['vote_average'],
                  ),
                )
                .toList()
            : [],
    lastEpisodeToAir:
        lastEpisodeToAir != null
            ? () {
              final g = jsonDecode(lastEpisodeToAir!);
              return EpisodeToAir(
                id: g['id'],
                name: g['name'],
                overview: g['overview'],
                voteAverage: g['vote_average'],
                voteCount: g['vote_count'],
                airDate: g['air_date'],
                episodeNumber: g['episode_number'],
                episodeType: g['episode_type'],
                productionCode: g['production_code'],
                runtime: g['runtime'],
                seasonNumber: g['season_number'],
                showId: g['show_id'],
                stillPath: g['still_path'],
              );
            }()
            : null,

    nextEpisodeToAir:
        nextEpisodeToAir != null
            ? () {
              final g = jsonDecode(nextEpisodeToAir!);
              return EpisodeToAir(
                id: g['id'],
                name: g['name'],
                overview: g['overview'],
                voteAverage: g['vote_average'],
                voteCount: g['vote_count'],
                airDate: g['air_date'],
                episodeNumber: g['episode_number'],
                episodeType: g['episode_type'],
                productionCode: g['production_code'],
                runtime: g['runtime'],
                seasonNumber: g['season_number'],
                showId: g['show_id'],
                stillPath: g['still_path'],
              );
            }()
            : null,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    posterPath,
    backdropPath,
    overview,
    voteAverage,
    genres,
    popularity,
    createdBy,
    seasons,
    lastEpisodeToAir,
    nextEpisodeToAir,
  ];
}
