import 'package:equatable/equatable.dart';
import 'package:list_test/features/Home/data/models/species_model.dart';

class SpeciesState extends Equatable {
  final List<SpeciesModel> species;
  final bool isLoading;
  final int currentPage;
  final bool hasNextPage;
  final String? errorMessage;

  const SpeciesState({
    this.species = const [],
    this.isLoading = false,
    this.currentPage = 1,
    this.hasNextPage = true,
    this.errorMessage,
  });

  SpeciesState copyWith({
    List<SpeciesModel>? species,
    bool? isLoading,
    int? currentPage,
    bool? hasNextPage,
    String? errorMessage,
  }) {
    return SpeciesState(
      species: species ?? this.species,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    species,
    isLoading,
    currentPage,
    hasNextPage,
    errorMessage,
  ];
}
