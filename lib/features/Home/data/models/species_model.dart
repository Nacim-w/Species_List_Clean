import 'package:equatable/equatable.dart';

class SpeciesModel extends Equatable {
  final String name;
  final String classification;

  const SpeciesModel({required this.name, required this.classification});

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      name: json['name'] ?? '',
      classification: json['classification'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'classification': classification};
  }

  @override
  List<Object?> get props => [name, classification];
}
