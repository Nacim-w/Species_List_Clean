import '../../data/datasources/species_remote_data_source.dart';
import '../repositories/species_repository.dart';

class GetSpecies {
  final SpeciesRepository repository;

  GetSpecies(this.repository);

  Future<PaginatedSpeciesResponse> call({required int page}) {
    return repository.getSpecies(page: page);
  }
}
