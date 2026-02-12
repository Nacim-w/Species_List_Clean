import 'package:equatable/equatable.dart';
import '../../../domain/entities/species.dart';

class SpeciesState extends Equatable {
  final List<Species> species;
  final bool isLoading;
  final int currentPage;
  final bool hasNextPage;
  final String? errorMessage;
  final String? loadingButton; // "prev", "next", or null

  const SpeciesState({
    this.species = const [],
    this.isLoading = false,
    this.currentPage = 1,
    this.hasNextPage = true,
    this.errorMessage,
    this.loadingButton,
  });

  SpeciesState copyWith({
    List<Species>? species,
    bool? isLoading,
    int? currentPage,
    bool? hasNextPage,
    String? errorMessage,
    String? loadingButton,
  }) {
    return SpeciesState(
      species: species ?? this.species,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      errorMessage: errorMessage,
      loadingButton: loadingButton,
    );
  }

  @override
  List<Object?> get props => [
    species,
    isLoading,
    currentPage,
    hasNextPage,
    errorMessage,
    loadingButton,
  ];
}
