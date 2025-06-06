import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/genre.dart';
import '../../../../domain/entities/movies/movie_detail.dart';
import '../movie_detail_model.dart';

/**
 * MovieDetailTable adalah model tabel lokal (biasanya untuk SQLite atau
 * penyimpanan lokal) yang merepresentasikan detail film.
 * Model ini menjembatani antara:
 * - Data dari/dan ke SQLite (database lokal)
 * - Data entity MovieDetail yang digunakan di domain layer
 */

class MovieDetailTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? runtime;
  final double? voteAverage;
  final String? releaseDate;

  // simpan genres dalam bentuk String, contoh: "Action, Drama"
  // genres disimpan sebagai String? dalam format JSON agar bisa disimpan
  // di SQLite (karena SQLite tidak bisa menyimpan langsung List atau objek kompleks)
  final String? genres;

  const MovieDetailTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.runtime,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  });

  // Membuat instance MovieDetailTable dari MovieDetail entity (domain layer)
  // genres dikonversi ke JSON string agar bisa disimpan sebagai TEXT di SQLite
  // Mengubah MovieDetail dari domain layer → format MovieDetailTable (untuk simpan lokal)
  factory MovieDetailTable.fromEntity(MovieDetail movie) => MovieDetailTable(
    id: movie.id,
    title: movie.title,
    posterPath: movie.posterPath,
    overview: movie.overview,
    runtime: movie.runtime,
    voteAverage: movie.voteAverage,
    releaseDate: movie.releaseDate,
    // genres: movie.genres?.map((g) => g.name).join(', '),

    // Simpan
    genres: jsonEncode(
      movie.genres?.map((g) => {'id': g.id, 'name': g.name}).toList(),
    ),
  );

  // Membuat instance MovieDetailTable dari Map<String, dynamic> (biasa dipakai saat membaca data dari SQLite)
  factory MovieDetailTable.fromMap(Map<String, dynamic> map) =>
      MovieDetailTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        runtime: map['runtime'],
        voteAverage: map['voteAverage']?.toDouble(),
        releaseDate: map['releaseDate'],
        genres: map['genres'],
      );

  // untuk merubah MovieModel menjadi MovieDetailTable
  // Konversi dari response DTO ke bentuk yang bisa disimpan di lokal
  factory MovieDetailTable.fromDetailDTO(MovieDetailResponse detail) =>
      MovieDetailTable(
        id: detail.id,
        title: detail.title,
        posterPath: detail.posterPath,
        overview: detail.overview,
        runtime: detail.runtime,
        voteAverage: detail.voteAverage,
        releaseDate: detail.releaseDate,
        // genres: detail.genres.map((g) => g.name).join(', '),
        genres: jsonEncode(
          detail.genres.map((g) => {'id': g.id, 'name': g.name}).toList(),
        ),
      );

  // Mengubah objek menjadi Map Json (misal saat insert ke SQLite)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'posterPath': posterPath,
    'overview': overview,
    'runtime': runtime,
    'voteAverage': voteAverage,
    'releaseDate': releaseDate,
    'genres': genres,
  };

  // Mengubah kembali MovieDetailTable menjadi MovieDetail entity
  // JSON string di-decode kembali menjadi List<Genre>
  // 	Ubah dari format lokal (MovieDetailTable) ke MovieDetail (biasanya untuk ditampilkan di UI)
  MovieDetail toEntity() => MovieDetail.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
    runtime: runtime,
    voteAverage: voteAverage,
    releaseDate: releaseDate,
    // genres: genres,

    // Ambil
    genres:
        genres != null
            ? (jsonDecode(genres!) as List)
                .map((g) => Genre(id: g['id'], name: g['name']))
                .toList()
            : [],
  );

  @override
  List<Object?> get props => [
    id,
    title,
    posterPath,
    overview,
    runtime,
    voteAverage,
    releaseDate,
    genres,
  ];
}
