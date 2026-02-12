import 'package:dio/dio.dart';
import '../../domain/repositories/species_repository.dart';
import '../datasources/species_remote_data_source.dart';

class SpeciesRepositoryImpl implements SpeciesRepository {
  final SpeciesRemoteDataSource remoteDataSource;

  SpeciesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaginatedSpeciesResponse> getSpecies({
    required int page,
    CancelToken? cancelToken,
  }) {
    return remoteDataSource.getSpecies(page: page, cancelToken: cancelToken);
  }
}
