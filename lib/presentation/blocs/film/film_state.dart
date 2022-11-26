part of 'film_bloc.dart';

@freezed
class FilmState with _$FilmState {
  const factory FilmState({
    // Watchlist
    required bool isExistedInWatchlist,
    required List<FilmEntity> watchlistFilms,
    required ViewState watchlistFilmsState,

    // Movie
    required ViewState nowPlayingMovieFilmsState,
    required List<FilmEntity> nowPlayingMovieFilms,
    required ViewState popularMovieFilmsState,
    required List<FilmEntity> popularMovieFilms,
    required ViewState topRatedMovieFilmsState,
    required List<FilmEntity> topRatedMovieFilms,
    required ViewState upComingMovieFilmsState,
    required List<FilmEntity> upComingMovieFilms,

    // TV
    required ViewState nowPlayingTvFilmsState,
    required List<FilmEntity> nowPlayingTvFilms,
    required ViewState popularTvFilmsState,
    required List<FilmEntity> popularTvFilms,
    required ViewState topRatedTvFilmsState,
    required List<FilmEntity> topRatedTvFilms,

    // Recommendation
    required ViewState recommendationFilmsState,
    required List<FilmEntity> recommendationFilms,

    // Search
    required ViewState searchFilmsState,
    required String searchQuery,
    required List<FilmEntity> searchFilms,

    // HomePage drawer index
    required int homePageDrawerIndex,
    required int watchlistTabIndex,

    // PerCategory
    required List<FilmEntity> listFilmsPerCategory,
    required FilmType listFilmsPerCategoryType,
    required FilmSections filmSectionType,

    // Reviews
    required ViewState reviewState,
    required ReviewEntity reviewFilm,
  }) = _FilmState;

  factory FilmState.initial() => const FilmState(
        // Watchlist
        isExistedInWatchlist: false,
        watchlistFilmsState: ViewState.initial(),
        watchlistFilms: [],

        // PerCategory
        listFilmsPerCategory: [],
        listFilmsPerCategoryType: FilmType.movie,
        filmSectionType: FilmSections.nowPlaying,

        // Movie
        nowPlayingMovieFilms: [],
        nowPlayingMovieFilmsState: ViewState.initial(),
        popularMovieFilms: [],
        popularMovieFilmsState: ViewState.initial(),
        topRatedMovieFilms: [],
        topRatedMovieFilmsState: ViewState.initial(),
        upComingMovieFilmsState: ViewState.initial(),
        upComingMovieFilms: [],

        // TV
        nowPlayingTvFilms: [],
        nowPlayingTvFilmsState: ViewState.initial(),
        popularTvFilms: [],
        popularTvFilmsState: ViewState.initial(),
        topRatedTvFilms: [],
        topRatedTvFilmsState: ViewState.initial(),

        // Search
        searchFilms: [],
        searchFilmsState: ViewState.initial(),
        searchQuery: '',

        // Reviews
        reviewState: ViewState.initial(),
        reviewFilm: ReviewEntity(
          id: 0,
          page: 0,
          results: [],
          totalPages: 0,
          totalResults: 0,
        ),

        // Recommendation
        recommendationFilmsState: ViewState.initial(),
        recommendationFilms: [],

        // HomePage drawer index
        homePageDrawerIndex: 0,
        watchlistTabIndex: 0,
      );
}
