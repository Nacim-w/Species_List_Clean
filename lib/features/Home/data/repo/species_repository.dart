import 'package:generic_requester/generic_requester.dart';
import 'package:list_test/features/Home/data/models/species_model.dart';

class PaginatedSpeciesResponse extends ModelingProtocol {
  final List<SpeciesModel> species;
  final bool hasNextPage;

  PaginatedSpeciesResponse({required this.species, required this.hasNextPage});

  @override
  PaginatedSpeciesResponse fromJson(json) {
    final List results = (json['results'] as List?) ?? [];
    return PaginatedSpeciesResponse(
      species: results
          .map((e) => SpeciesModel.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      hasNextPage: json['next'] != null,
    );
  }
}

/// Abstract repository interface
abstract class SpeciesRepository {
  Future<Either<Exception, PaginatedSpeciesResponse>> getSpecies({
    required int page,
  });
}

/// Implementation of SpeciesRepository using `generic_requester`.
class SpeciesRepositoryImpl extends SpeciesRepository {
  SpeciesRepositoryImpl();

  @override
  Future<Either<Exception, PaginatedSpeciesResponse>> getSpecies({
    required int page,
  }) async {
    final requestPerformer = RequestPerformer(Dio());

    return await requestPerformer.performDecodingRequest(
      baseUrl: 'https://swapi.dev/api',
      path: '/species/',
      method: RestfulMethods.get,
      queryParameters: {'page': page},
      decodableModel: PaginatedSpeciesResponse(
        species: const [],
        hasNextPage: false,
      ),
    );
  }
}
