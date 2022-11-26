import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchFilmUseCase {
  final FilmRepository _repository;

  const SearchFilmUseCase(this._repository);

  Future<DataState<List<FilmEntity>>> call(FilmType type, String query) async =>
      await _repository.searchFilms(type, query);
}
