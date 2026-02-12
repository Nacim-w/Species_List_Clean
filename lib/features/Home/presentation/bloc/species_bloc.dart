import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_species.dart';
import 'events/species_event.dart';
import 'states/species_state.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final GetSpecies getSpecies;
  CancelToken? _cancelToken;

  SpeciesBloc({required this.getSpecies}) : super(const SpeciesState()) {
    on<FetchSpeciesEvent>(_onFetch);
    on<NextPageEvent>(_onNextPage);
    on<PreviousPageEvent>(_onPreviousPage);
  }

  Future<void> _onFetch(
    FetchSpeciesEvent event,
    Emitter<SpeciesState> emit,
  ) async {
    if (state.isLoading) return;

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    // preserve loadingButton here
    emit(state.copyWith(isLoading: true, loadingButton: state.loadingButton));

    try {
      final result = await getSpecies(page: state.currentPage);

      emit(
        state.copyWith(
          species: result.species,
          hasNextPage: result.hasNextPage,
          isLoading: false,
          loadingButton: null, // reset after finished
        ),
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) return;
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.message,
          loadingButton: null,
        ),
      );
    }
  }

  void _onNextPage(_, Emitter<SpeciesState> emit) {
    if (!state.hasNextPage || state.isLoading) return;
    emit(
      state.copyWith(currentPage: state.currentPage + 1, loadingButton: "next"),
    );
    add(FetchSpeciesEvent());
  }

  void _onPreviousPage(_, Emitter<SpeciesState> emit) {
    if (state.currentPage == 1 || state.isLoading) return;
    emit(
      state.copyWith(currentPage: state.currentPage - 1, loadingButton: "prev"),
    );
    add(FetchSpeciesEvent());
  }
}
