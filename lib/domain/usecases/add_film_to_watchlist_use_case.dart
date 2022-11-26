import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddFilmToWatchlistUseCase {
  final FilmRepository _repository;

  const AddFilmToWatchlistUseCase(this._repository);

  Future<DataState<bool>> call(FilmType type, FilmEntity film) async =>
      await _repository.addFilmToWatchlist(type, film);
}
