import 'package:equatable/equatable.dart';
import '../../domain/entities/genre.dart';

/*
 * Jika diperhatikan kembali, data sources akan mengembalikan model. Anda pasti
 * familier dengan istilah tersebut, bukan? Model merupakan kelas Dart object
 * layaknya entity. Lalu, kenapa tidak menggunakan kelas entity saja? Bedanya,
 * data model masih mentah (raw) karena masih berupa nilai yang dikembalikan data sources.
 * Misalnya, ketika menggunakan http package, kita membutuhkan kode konversi
 * seperti fromJson atau toJson. Untuk local data source, mungkin kita juga
 * menambahkan beberapa field tambahan pada database. Tentunya, kita tidak ingin
 * hal tersebut masuk ke dalam layer domain karena akan membuatnya sangat
 * terpengaruh dengan library pihak ketiga yang digunakan.
 *
 * Perlu menyediakan fungsi untuk mengonversi model menjadi entity ketika memasuki layer domain.
 * dengan menggunakan toEntity()
 */

class GenreModel extends Equatable {
  GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  Genre toEntity() {
    return Genre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}