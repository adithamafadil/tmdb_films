import 'dart:async';

import 'package:tmdb_films/data/models/film/film_model.dart';
import 'package:tmdb_films/domain/db/film_db_entity.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilmLocalDataSource {
  final Box _box;
  const FilmLocalDataSource(this._box);

  Future<DataState<bool>> addFilmToWatchlist(
      FilmType type, FilmModel film) async {
    try {
      _box.put(
        '$type-${film.id}',
        FilmDbEntity()
          ..id = film.id
          ..title = film.name ?? film.title ?? ''
          ..overview = film.overview
          ..posterPath = film.posterPath
          ..voteAverage = film.voteAverage
          ..type = type.toString(),
      );
      return const DataState.success(data: true);
    } catch (e, stackTrace) {
      return DataState.error(
        data: false,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<DataState<bool>> getHasExistInWatchlist(FilmType type, int id) async {
    try {
      return DataState.success(data: _box.containsKey('$type-$id'));
    } catch (e, stackTrace) {
      return DataState.error(
        data: false,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<DataState<List<FilmModel>>> getWatchlistFilms(
    FilmType type,
  ) async {
    try {
      final data = _box.values
          .cast<FilmDbEntity>()
          .where((i) => i.type == type.toString())
          .map(
            (e) => FilmModel(
              id: e.id,
              name: e.title,
              title: e.title,
              voteAverage: e.voteAverage,
              posterPath: e.posterPath ?? '',
              overview: e.overview,
            ),
          )
          .toList();
      return DataState.success(data: data);
    } catch (e, stackTrace) {
      return DataState.error(
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<DataState<bool>> removeFilmFromWatchlist(FilmType type, int id) async {
    try {
      _box.delete('$type-$id');
      return const DataState.success(data: true);
    } catch (e, stackTrace) {
      return DataState.error(
        data: false,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }
}
