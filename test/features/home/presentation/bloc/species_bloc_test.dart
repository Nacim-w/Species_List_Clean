import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generic_requester/generic_requester.dart';
import 'package:mocktail/mocktail.dart';
import 'package:list_test/features/Home/data/models/species_model.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import 'package:list_test/features/Home/presentation/bloc/species_bloc.dart';
import 'package:list_test/features/Home/presentation/bloc/events/species_event.dart';
import 'package:list_test/features/Home/presentation/bloc/states/species_state.dart';

// Mock repository
class MockSpeciesRepository extends Mock implements SpeciesRepository {}

void main() {
  late SpeciesBloc bloc;
  late MockSpeciesRepository repository;

  final speciesPage1 = [
    const SpeciesModel(name: 'Species 1', classification: 'Mammal'),
    const SpeciesModel(name: 'Species 2', classification: 'Reptile'),
  ];

  final speciesPage2 = [
    const SpeciesModel(name: 'Species 3', classification: 'Bird'),
    const SpeciesModel(name: 'Species 4', classification: 'Fish'),
  ];

  setUp(() {
    repository = MockSpeciesRepository();
    bloc = SpeciesBloc(repository);
  });

  test('initial state is correct', () {
    expect(bloc.state, const SpeciesState());
  });

  // Test FetchSpeciesEvent success
  blocTest<SpeciesBloc, SpeciesState>(
    'emits loading then data when FetchSpeciesEvent succeeds',
    build: () {
      when(() => repository.getSpecies(page: 1)).thenAnswer(
        (_) async => Right<Exception, PaginatedSpeciesResponse>(
          PaginatedSpeciesResponse(species: speciesPage1, hasNextPage: true),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchSpeciesEvent()),
    expect: () => [
      const SpeciesState(isLoading: true),
      SpeciesState(
        species: speciesPage1,
        currentPage: 1,
        hasNextPage: true,
        isLoading: false,
      ),
    ],
  );

  // Test LoadNextPageIfNeeded success
  blocTest<SpeciesBloc, SpeciesState>(
    'emits loading then data when LoadNextPageIfNeeded succeeds',
    build: () {
      when(() => repository.getSpecies(page: 2)).thenAnswer(
        (_) async => Right<Exception, PaginatedSpeciesResponse>(
          PaginatedSpeciesResponse(species: speciesPage2, hasNextPage: false),
        ),
      );
      return bloc;
    },
    seed: () =>
        SpeciesState(species: speciesPage1, currentPage: 1, hasNextPage: true),
    act: (bloc) => bloc.add(LoadNextPageIfNeeded()),
    expect: () => [
      SpeciesState(
        species: speciesPage1,
        currentPage: 1,
        hasNextPage: true,
        isLoading: true,
      ),
      SpeciesState(
        species: [...speciesPage1, ...speciesPage2],
        currentPage: 2,
        hasNextPage: false,
        isLoading: false,
      ),
    ],
  );

  // Test FetchSpeciesEvent failure
  blocTest<SpeciesBloc, SpeciesState>(
    'emits loading then error when FetchSpeciesEvent fails',
    build: () {
      when(() => repository.getSpecies(page: 1)).thenAnswer(
        (_) async =>
            Left<Exception, PaginatedSpeciesResponse>(Exception('Failed')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchSpeciesEvent()),
    expect: () => [
      const SpeciesState(isLoading: true),
      SpeciesState(
        species: const [],
        currentPage: 1,
        hasNextPage: true,
        isLoading: false,
        errorMessage: 'Exception: Failed',
      ),
    ],
  );

  // Edge case: LoadNextPageIfNeeded does nothing if no next page
  blocTest<SpeciesBloc, SpeciesState>(
    'does nothing when LoadNextPageIfNeeded is called but hasNextPage is false',
    build: () => bloc,
    seed: () =>
        SpeciesState(species: speciesPage1, currentPage: 1, hasNextPage: false),
    act: (bloc) => bloc.add(LoadNextPageIfNeeded()),
    expect: () => [], // no states emitted
  );

  // Edge case: LoadNextPageIfNeeded does nothing if already loading
  blocTest<SpeciesBloc, SpeciesState>(
    'does nothing when LoadNextPageIfNeeded is called but isLoading is true',
    build: () => bloc,
    seed: () => SpeciesState(
      species: speciesPage1,
      currentPage: 1,
      hasNextPage: true,
      isLoading: true,
    ),
    act: (bloc) => bloc.add(LoadNextPageIfNeeded()),
    expect: () => [], // no states emitted
  );
}
