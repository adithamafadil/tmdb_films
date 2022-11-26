import 'package:tmdb_films/data/models/film/film_model.dart';
import 'package:tmdb_films/data/models/review/review_model.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilmRemoteDataSource {
  final Dio _client;
  const FilmRemoteDataSource(this._client);

  Future<DataState<List<FilmModel>>> getNowPlayingFilms(FilmType type) async {
    try {
      String path = '';

      if (type.isTvFilms()) path = '${type.endpoint()}/airing_today';
      if (type.isMovieFilms()) path = '${type.endpoint()}/now_playing';

      final response = await _client.get(path);

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getPopularFilms(FilmType type) async {
    try {
      final response = await _client.get('${type.endpoint()}/popular');

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getRecommendationFilms(
    FilmType type,
    int id,
  ) async {
    try {
      final response = await _client.get(
        '${type.endpoint()}/$id/recommendations',
      );

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getTopRatedFilms(FilmType type) async {
    try {
      final response = await _client.get('${type.endpoint()}/top_rated');

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> searchFilms(
      FilmType type, String query) async {
    try {
      final response =
          await _client.get('/search${type.endpoint()}?query=$query');

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<ReviewModel>> getFilmReviews(
    FilmType type,
    int id,
    int? page,
  ) async {
    try {
      final reviewPage = page ?? 1;
      final response = await _client.get(
        '/${type.endpoint()}/$id/reviews?page=$reviewPage',
      );

      final result = ReviewModel.fromJson(response.data);

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getUpComingMovies() async {
    try {
      final response = await _client.get('/movie/upcoming');

      final result = (response.data['results'] as List)
          .map((e) => FilmModel.fromJson(e))
          .toList();

      return DataState.success(data: result);
    } on DioError catch (e) {
      return DataState.error(
        message: e.message,
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }
}
