import 'package:equatable/equatable.dart';

/*
 * Penjelasan Entity
 * Entities juga dikenal dengan domain objects atau domain model.
 * Entity merupakan object yang akan diproses dan dioperasikan pada aplikasi.
 *
 * menambahkan package equatable untuk memudahkan komparasi nilai antara dua objek.
 * Jika kita melakukan komparasi objek dengan operator ==,
 * maka yang dibandingkan adalah alamat memorinya.
 */
class Genre extends Equatable {
  Genre({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
