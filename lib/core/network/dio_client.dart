import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return dio.get(
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }
}
