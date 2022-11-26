import 'package:tmdb_films/domain/entities/review/review_entity.dart';
import 'package:tmdb_films/domain/repositories/film_repository.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFilmReviewsUseCase {
  final FilmRepository _repository;

  const GetFilmReviewsUseCase(this._repository);

  Future<DataState<ReviewEntity>> call(
    FilmType type,
    int id,
    int? page,
  ) async =>
      await _repository.getFilmReviews(type, id, page);
}
