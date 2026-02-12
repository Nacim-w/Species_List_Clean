import 'package:dartz/dartz.dart';
import 'package:list_test/core/network/dio_client.dart';
import 'package:list_test/features/Home/data/models/species_model.dart';

/// Response object for paginated species
class PaginatedSpeciesResponse {
  final List<SpeciesModel> species;
  final bool hasNextPage;

  PaginatedSpeciesResponse({required this.species, required this.hasNextPage});
}

/// Abstract repository interface
abstract class SpeciesRepository {
  final DioClient dioClient;

  SpeciesRepository({required this.dioClient});

  /// Returns Either a failure (Exception) or a paginated response
  Future<Either<Exception, PaginatedSpeciesResponse>> getSpecies({
    required int page,
  });
}

/// Implementation of SpeciesRepository
class SpeciesRepositoryImpl extends SpeciesRepository {
  SpeciesRepositoryImpl({required super.dioClient});

  @override
  Future<Either<Exception, PaginatedSpeciesResponse>> getSpecies({
    required int page,
  }) async {
    try {
      final response = await dioClient.get(
        '/species/',
        queryParameters: {'page': page},
      );

      final List results = response.data['results'];

      final data = PaginatedSpeciesResponse(
        species: results.map((e) => SpeciesModel.fromJson(e)).toList(),
        hasNextPage: response.data['next'] != null,
      );

      return Right(data);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
