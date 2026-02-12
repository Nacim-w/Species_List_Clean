import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:list_test/features/Home/data/repo/species_repository.dart';
import 'network/dio_client.dart';
import '../features/Home/presentation/bloc/species_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://swapi.dev/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  // Dio client
  sl.registerLazySingleton(() => DioClient(sl()));

  // Repository (datasource)
  sl.registerLazySingleton(() => SpeciesRepository(sl()));

  // Bloc
  sl.registerFactory(() => SpeciesBloc(sl()));
}
