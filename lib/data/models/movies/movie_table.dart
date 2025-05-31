import 'package:equatable/equatable.dart';
import '../../../domain/entities/movies/movie.dart';
import '../../../domain/entities/movies/movie_detail.dart';
import 'movie_detail_model.dart';
import 'movie_model.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    overview: movie.overview,
  );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
    id: map['id'],
    title: map['title'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  // untuk merubah MovieModel menjadi MovieTable
  factory MovieTable.fromDTO(MovieModel movie) => MovieTable(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    overview: movie.overview,
  );

  factory MovieTable.fromDetailDTO(MovieDetailResponse detail) => MovieTable(
    id: detail.id,
    title: detail.title,
    posterPath: detail.posterPath,
    overview: detail.overview,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterPath': posterPath,
    'overview': overview,
  };

  Movie toEntity() => Movie.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
