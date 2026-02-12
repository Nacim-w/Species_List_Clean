import '../../domain/entities/species.dart';

class SpeciesModel extends Species {
  SpeciesModel({required super.name, required super.description});

  factory SpeciesModel.empty() {
    return SpeciesModel(name: '', description: '');
  }

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      name: json['name'] ?? '',
      description: json['classification'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'classification': description};
  }

  SpeciesModel copyWith({String? name, String? description}) {
    return SpeciesModel(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
