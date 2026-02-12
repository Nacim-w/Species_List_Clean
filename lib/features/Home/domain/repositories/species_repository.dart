import '../../data/datasources/species_remote_data_source.dart';

abstract class SpeciesRepository {
  Future<PaginatedSpeciesResponse> getSpecies({required int page});
}
