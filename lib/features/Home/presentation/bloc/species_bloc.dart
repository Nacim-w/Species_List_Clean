import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import 'package:list_test/features/Home/presentation/bloc/events/species_event.dart';
import 'package:list_test/features/Home/presentation/bloc/states/species_state.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final SpeciesRepository repository;
  CancelToken? _cancelToken;

  SpeciesBloc(this.repository) : super(const SpeciesState()) {
    on<FetchSpeciesEvent>(_onFetch);
    on<NextPageEvent>(_onNext);
    on<PreviousPageEvent>(_onPrevious);
  }

  Future<void> _onFetch(
    FetchSpeciesEvent event,
    Emitter<SpeciesState> emit,
  ) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    emit(state.copyWith(isLoading: true));

    try {
      final result = await repository.getSpecies(
        page: state.currentPage,
        cancelToken: _cancelToken,
      );

      emit(
        state.copyWith(
          species: result.species,
          hasNextPage: result.hasNextPage,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onNext(_, Emitter<SpeciesState> emit) {
    if (!state.hasNextPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
    add(FetchSpeciesEvent());
  }

  void _onPrevious(_, Emitter<SpeciesState> emit) {
    if (state.currentPage == 1) return;
    emit(state.copyWith(currentPage: state.currentPage - 1));
    add(FetchSpeciesEvent());
  }
}
