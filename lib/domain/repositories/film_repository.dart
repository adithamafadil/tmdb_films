import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';
import 'package:tmdb_films/state/data/data_state.dart';
import 'package:tmdb_films/utils/enum.dart';

abstract class FilmRepository {
  // Films
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms(FilmType type);
  Future<DataState<List<FilmEntity>>> getPopularFilms(FilmType type);
  Future<DataState<List<FilmEntity>>> getTopRatedFilms(FilmType type);
  Future<DataState<List<FilmEntity>>> getUpComingFilms();
  Future<DataState<List<FilmEntity>>> getRecommendationFilms(
    FilmType type,
    int id,
  );
  Future<DataState<List<FilmEntity>>> searchFilms(FilmType type, String query);

  // Watchlist
  Future<DataState<List<FilmEntity>>> getWatchlistFilms(FilmType type);
  Future<DataState<bool>> addFilmToWatchlist(FilmType type, FilmEntity film);
  Future<DataState<bool>> getHasExistInWatchlist(FilmType type, int id);
  Future<DataState<bool>> removeFilmFromWatchlist(FilmType type, int id);

  // Reviews
  Future<DataState<ReviewEntity>> getFilmReviews(
    FilmType type,
    int id,
    int? page,
  );
}
