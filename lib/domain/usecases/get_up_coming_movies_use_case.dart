import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUpComingMoviesUseCase {
  final FilmRepository _repository;

  const GetUpComingMoviesUseCase(this._repository);

  Future<DataState<List<FilmEntity>>> call() async =>
      await _repository.getUpComingFilms();
}
