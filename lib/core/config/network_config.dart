import 'package:generic_requester/generic_requester.dart';

class NetworkConfig {
  static void setup() {
    RequestPerformer.configure(
      BaseOptions(
        baseUrl: 'https://swapi.dev/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
      headers: {'Content-Type': 'application/json'},
      interceptor: null,
      debuggingEnabled: true,
      mockingEnabled: false,
    );
  }
}
