import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:list_test/features/Home/domain/repositories/species_repository.dart';

import '../features/Home/data/datasources/species_remote_data_source.dart';
import '../features/Home/data/repo/species_repository_impl.dart';
import '../features/Home/domain/usecases/get_species.dart';
import '../features/Home/presentation/bloc/species_bloc.dart';
import 'network/dio_client.dart';

final sl = GetIt.instance;

void init() {
  // Dio
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://swapi.dev/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton(() => DioClient(sl()));

  // Data source
  sl.registerLazySingleton(() => SpeciesRemoteDataSource(dioClient: sl()));

  // Repository
  sl.registerLazySingleton<SpeciesRepository>(
    () => SpeciesRepositoryImpl(remoteDataSource: sl()),
  );
  // Use case
  sl.registerLazySingleton(() => GetSpecies(sl()));

  // Bloc
  sl.registerFactory(() => SpeciesBloc(getSpecies: sl()));
}
