import 'package:ditonton_clean_architecture/domain/entities/tv/production_companies.dart';
import 'package:equatable/equatable.dart';

class ProductionCompaniesModel extends Equatable {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompaniesModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompaniesModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath,
    "name": name,
    "origin_country": originCountry,
  };

  ProductionCompanies toEntity() {
    return ProductionCompanies(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
