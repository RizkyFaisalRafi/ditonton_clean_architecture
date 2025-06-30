import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../module/tv_series.dart';

class CreatedByModel extends Equatable {
  final int? id;
  final String? creditId;
  final String? name;
  final String? originalName;
  final int? gender;
  final String? profilePath;

  const CreatedByModel({
    this.id,
    this.creditId,
    this.name,
    this.originalName,
    this.gender,
    this.profilePath,
  });

  factory CreatedByModel.fromJson(String str) =>
      CreatedByModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatedByModel.fromMap(Map<String, dynamic> json) => CreatedByModel(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    originalName: json["original_name"],
    gender: json["gender"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "credit_id": creditId,
    "name": name,
    "original_name": originalName,
    "gender": gender,
    "profile_path": profilePath,
  };

  CreatedBy toEntity() {
    return CreatedBy(
      id: id,
      creditId: creditId,
      name: name,
      originalName: originalName,
      gender: gender,
      profilePath: profilePath,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    creditId,
    name,
    originalName,
    gender,
    profilePath,
  ];
}
