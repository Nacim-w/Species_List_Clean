import 'package:get_it/get_it.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import '../features/Home/presentation/bloc/species_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Repository (datasource)
  sl.registerLazySingleton<SpeciesRepository>(() => SpeciesRepositoryImpl());
  // Bloc
  sl.registerFactory(() => SpeciesBloc(sl()));
}
