import 'package:tmdb_films/utils/http_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  @preResolve
  Future<Dio> get client => HttpConfig.client();

  @lazySingleton
  Box get box => Hive.box('watchlist');
}
