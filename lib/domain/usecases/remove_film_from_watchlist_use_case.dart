import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoveFilmFromWatchlistUseCase {
  final FilmRepository _repository;

  const RemoveFilmFromWatchlistUseCase(this._repository);

  Future<DataState<bool>> call(FilmType type, int id) async =>
      await _repository.removeFilmFromWatchlist(type, id);
}
