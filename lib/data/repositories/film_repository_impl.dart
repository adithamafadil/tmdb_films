import 'package:tmdb_films/data/models/review/review_model.dart';
import 'package:tmdb_films/data/repositories/src/film_local_datasource.dart';
import 'package:tmdb_films/data/repositories/src/film_remote_datasource.dart';
import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';
import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/mapper/film_mapper.dart';
import 'package:tmdb_films/mapper/review_mapper.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FilmRepository)
class FilmRepositoryImpl implements FilmRepository {
  final FilmRemoteDataSource _remoteDataSource;
  final FilmLocalDataSource _localDataSource;
  final FilmMapper _filmMapper;
  final ReviewMapper _reviewMapper;

  const FilmRepositoryImpl(
    this._localDataSource,
    this._filmMapper,
    this._remoteDataSource,
    this._reviewMapper,
  );

  @override
  Future<DataState<bool>> addFilmToWatchlist(
    FilmType type,
    FilmEntity film,
  ) async {
    return await _localDataSource.addFilmToWatchlist(
      type,
      _filmMapper.entityToModel(film),
    );
  }

  @override
  Future<DataState<bool>> getHasExistInWatchlist(FilmType type, int id) async =>
      await _localDataSource.getHasExistInWatchlist(type, id);

  @override
  Future<DataState<List<FilmEntity>>> getUpComingFilms() async {
    final result = await _remoteDataSource.getUpComingMovies();

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms(FilmType type) async {
    final result = await _remoteDataSource.getNowPlayingFilms(type);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getPopularFilms(FilmType type) async {
    final result = await _remoteDataSource.getPopularFilms(type);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getRecommendationFilms(
      FilmType type, int id) async {
    final result = await _remoteDataSource.getRecommendationFilms(type, id);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getTopRatedFilms(FilmType type) async {
    final result = await _remoteDataSource.getTopRatedFilms(type);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getWatchlistFilms(FilmType type) async {
    final result = await _localDataSource.getWatchlistFilms(type);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> removeFilmFromWatchlist(
    FilmType type,
    int id,
  ) async {
    return await _localDataSource.removeFilmFromWatchlist(type, id);
  }

  @override
  Future<DataState<List<FilmEntity>>> searchFilms(
    FilmType type,
    String query,
  ) async {
    final result = await _remoteDataSource.searchFilms(type, query);

    return result.when(
      success: (data) => DataState.success(
        data: data.map((e) => _filmMapper.modelToEntity(e)).toList(),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          data: data?.map((e) => _filmMapper.modelToEntity(e)).toList(),
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<ReviewEntity>> getFilmReviews(
    FilmType type,
    int id,
    int? page,
  ) async {
    final result = await _remoteDataSource.getFilmReviews(type, id, page);

    return result.when(
      success: (data) => DataState.success(
        data: _reviewMapper.modelToEntity(data),
      ),
      error: (message, data, exception, stackTrace, statusCode) =>
          DataState.error(
        data: _reviewMapper.modelToEntity(data ??
            ReviewModel(
              id: id,
              page: 0,
              results: [],
              totalPages: 0,
              totalResults: 0,
            )),
        exception: exception,
        message: message,
        stackTrace: stackTrace,
        statusCode: statusCode,
      ),
    );
  }
}
