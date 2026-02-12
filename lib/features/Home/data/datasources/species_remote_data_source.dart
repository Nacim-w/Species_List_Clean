import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/species_model.dart';

class PaginatedSpeciesResponse {
  final List<SpeciesModel> species;
  final bool hasNextPage;

  PaginatedSpeciesResponse({required this.species, required this.hasNextPage});
}

class SpeciesRemoteDataSource {
  final DioClient dioClient;

  SpeciesRemoteDataSource({required this.dioClient});

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
