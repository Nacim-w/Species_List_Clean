import '../../domain/repositories/species_repository.dart';
import '../datasources/species_remote_data_source.dart';

class SpeciesRepositoryImpl implements SpeciesRepository {
  final SpeciesRemoteDataSource remoteDataSource;

  SpeciesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaginatedSpeciesResponse> getSpecies({required int page}) {
    return remoteDataSource.getSpecies(page: page);
  }
}
