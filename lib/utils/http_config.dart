import 'package:tmdb_films/utils/constants.dart';
import 'package:dio/dio.dart';

class HttpConfig {
  static Future<Dio> client() async {
    final dio = Dio(BaseOptions(
      baseUrl: APICore.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['api_key'] = APICore.apiKey;
        return handler.next(options);
      },
    ));

    return dio;
  }
}
