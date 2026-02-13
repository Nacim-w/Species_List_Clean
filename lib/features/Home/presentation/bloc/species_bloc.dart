import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import 'events/species_event.dart';
import 'states/species_state.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final SpeciesRepository repository;

  SpeciesBloc(this.repository) : super(const SpeciesState()) {
    on<FetchSpeciesEvent>(_onFetchFirstPage);
    on<LoadNextPageIfNeeded>(_onLoadNextPage);
  }

  Future<void> _onFetchFirstPage(
    FetchSpeciesEvent event,
    Emitter<SpeciesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await repository.getSpecies(page: 1);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.toString()),
      ),
      (data) => emit(
        state.copyWith(
          species: data.species,
          currentPage: 1,
          hasNextPage: data.hasNextPage,
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> _onLoadNextPage(
    LoadNextPageIfNeeded event,
    Emitter<SpeciesState> emit,
  ) async {
    if (state.isLoading || !state.hasNextPage) return;

    emit(state.copyWith(isLoading: true));

    final nextPage = state.currentPage + 1;
    final result = await repository.getSpecies(page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.toString()),
      ),
      (data) => emit(
        state.copyWith(
          species: [...state.species, ...data.species],
          currentPage: nextPage,
          hasNextPage: data.hasNextPage,
          isLoading: false,
        ),
      ),
    );
  }
}
