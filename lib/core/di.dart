import 'package:generic_requester/generic_requester.dart';
import 'package:get_it/get_it.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import '../features/Home/presentation/bloc/species_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Repository (datasource)
  sl.registerLazySingleton<SpeciesRepository>(() => SpeciesRepositoryImpl());
  // Bloc
  sl.registerFactory(() => SpeciesBloc(sl()));
  RequestPerformer.configure(
    BaseOptions(
      baseUrl: 'https://swapi.dev/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
    headers: {'Content-Type': 'application/json'},
    interceptor: null, // no interceptor, safe for now
    debuggingEnabled: true, // optional: logs requests
    mockingEnabled: false,
  );
}
