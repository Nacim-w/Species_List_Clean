import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import 'events/species_event.dart';
import 'states/species_state.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final SpeciesRepository repository;

  SpeciesBloc(this.repository) : super(const SpeciesState()) {
    on<FetchSpeciesEvent>(_onFetch);
    on<NextPageEvent>(_onNext);
    on<PreviousPageEvent>(_onPrevious);
  }

  Future<void> _onFetch(
    FetchSpeciesEvent event,
    Emitter<SpeciesState> emit,
  ) async {
    // preserve which button is triggering the load
    final loadingButton = state.loadingButton;

    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        loadingButton: loadingButton,
      ),
    );

    final result = await repository.getSpecies(page: state.currentPage);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.toString(),
            loadingButton: null,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            species: data.species,
            hasNextPage: data.hasNextPage,
            isLoading: false,
            loadingButton: null,
          ),
        );
      },
    );
  }

  void _onNext(_, Emitter<SpeciesState> emit) {
    if (!state.hasNextPage || state.isLoading) return;

    emit(
      state.copyWith(currentPage: state.currentPage + 1, loadingButton: "next"),
    );
    add(FetchSpeciesEvent());
  }

  void _onPrevious(_, Emitter<SpeciesState> emit) {
    if (state.currentPage == 1 || state.isLoading) return;

    emit(
      state.copyWith(currentPage: state.currentPage - 1, loadingButton: "prev"),
    );
    add(FetchSpeciesEvent());
  }
}
