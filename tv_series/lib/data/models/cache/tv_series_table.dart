import '../../../module/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvSeriesTable.fromEntity(TvDetail tvDetail) => TvSeriesTable(
    id: tvDetail.id!,
    name: tvDetail.name,
    posterPath: tvDetail.posterPath,
    overview: tvDetail.overview,
  );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  // untuk merubah TvModel menjadi TvTable
  factory TvSeriesTable.fromDTO(TvModel tvDetail) => TvSeriesTable(
    id: tvDetail.id!,
    name: tvDetail.name,
    posterPath: tvDetail.posterPath,
    overview: tvDetail.overview,
  );

  factory TvSeriesTable.fromDetailDTO(TvDetailResponse detail) => TvSeriesTable(
    id: detail.id!,
    name: detail.name,
    posterPath: detail.posterPath,
    overview: detail.overview,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  TvSeries toEntity() => TvSeries.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
