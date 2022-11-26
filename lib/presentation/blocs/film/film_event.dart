part of 'film_bloc.dart';

@freezed
class FilmEvent with _$FilmEvent {
  // Fetch all film at home event
  const factory FilmEvent.fetchMainPageEvent() = FetchMainPageEvent;

  // Get film events
  const factory FilmEvent.getUpComingFilmsEvent() = GetUpComingFilmEvent;
  const factory FilmEvent.getTopRatedFilmsEvent({required FilmType type}) =
      GetTopRatedFilmEvent;
  const factory FilmEvent.getNowPlayingFilmsEvent({required FilmType type}) =
      GetNowPlayingFilmsEvent;
  const factory FilmEvent.getPopularFilmsEvent({required FilmType type}) =
      GetPopularFilmsEvent;

  // Go to list from home event
  const factory FilmEvent.goToListPageEvent({
    required FilmType filmType,
    required FilmSections filmSectionType,
    required List<FilmEntity> films,
  }) = GoToListPageEvent;

  // Get recommendation films event
  const factory FilmEvent.getRecommendationFilmsEvent({
    required FilmType type,
    required int id,
  }) = GetRecommendationFilmsEvent;

  // Search films event
  const factory FilmEvent.searchFilmsEvent({
    required FilmType type,
    required String query,
  }) = SearchFilmsEvent;
  const factory FilmEvent.resetSearchEvent() = ResetSearchEvent;

  // Review event
  const factory FilmEvent.getFilmReviews({
    required FilmType type,
    required int id,
    int? page,
  }) = GetFilmReviewsEvent;

  // Watchlist
  const factory FilmEvent.watchlistCheckEvent({required FilmEntity thisFilm}) =
      WatchlistCheckEvent;
  const factory FilmEvent.getWatchlistEvent({required FilmType type}) =
      GetWatchlistEvent;
  const factory FilmEvent.addToWatchlistEvent({
    required FilmType type,
    required FilmEntity film,
  }) = AddToWatchlistEvent;
  const factory FilmEvent.getHasExistWatchlistEvent({
    required FilmType type,
    required int id,
  }) = GetHasExistWatchlistEvent;
  const factory FilmEvent.removeFilmFromWatchlistEvent({
    required FilmType type,
    required int id,
  }) = RemoveFilmFromWatchlistEvent;

  // Home Tabs
  const factory FilmEvent.changeHomeDrawerIndexEvent({required int index}) =
      ChangeHomeDrawerIndexEvent;
  const factory FilmEvent.changeWatchlistTabIndexEvent({required int index}) =
      ChangeWatchlistTabIndexEvent;
}
