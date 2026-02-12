import 'package:dio/dio.dart';
import 'package:list_test/core/network/dio_client.dart';
import 'package:list_test/features/Home/data/models/species_model.dart';

class SpeciesRepository {
  final DioClient dioClient;

  SpeciesRepository(this.dioClient);

  Future<PaginatedSpeciesResponse> getSpecies({
    required int page,
    CancelToken? cancelToken,
  }) async {
    final response = await dioClient.get(
      '/species/',
      queryParameters: {'page': page},
      cancelToken: cancelToken,
    );

    final List results = response.data['results'];

    return PaginatedSpeciesResponse(
      species: results.map((e) => SpeciesModel.fromJson(e)).toList(),
      hasNextPage: response.data['next'] != null,
    );
  }
}

class PaginatedSpeciesResponse {
  final List<SpeciesModel> species;
  final bool hasNextPage;

  PaginatedSpeciesResponse({required this.species, required this.hasNextPage});
}
