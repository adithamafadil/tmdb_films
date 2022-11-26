import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';
import 'package:tmdb_films/domain/usecases.dart';
import 'package:tmdb_films/state/view/view_state.dart';
import 'package:tmdb_films/utils/constants.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'film_event.dart';
part 'film_state.dart';
part 'film_bloc.freezed.dart';

@lazySingleton
class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final AddFilmToWatchlistUseCase _addFilmToWatchlistUseCase;
  final GetFilmReviewsUseCase _getFilmReviewsUseCase;
  final GetHasExistInWatchlistUseCase _getHasExistInWatchlistUseCase;
  final GetNowPlayingFilmsUseCase _getNowPlayingFilmsUseCase;
  final GetPopularFilmsUseCase _getPopularFilmsUseCase;
  final GetRecommendationFilmUseCase _getRecommendationFilmUseCase;
  final GetTopRatedFilmUseCase _getTopRatedFilmUseCase;
  final GetUpComingMoviesUseCase _getUpComingMoviesUseCase;
  final GetWatchlistFilmsUseCase _getWatchlistFilmsUseCase;
  final RemoveFilmFromWatchlistUseCase _removeFilmFromWatchlistUseCase;
  final SearchFilmUseCase _searchFilmUseCase;

  FilmBloc(
    this._addFilmToWatchlistUseCase,
    this._getFilmReviewsUseCase,
    this._getHasExistInWatchlistUseCase,
    this._getNowPlayingFilmsUseCase,
    this._getPopularFilmsUseCase,
    this._getRecommendationFilmUseCase,
    this._getTopRatedFilmUseCase,
    this._getUpComingMoviesUseCase,
    this._getWatchlistFilmsUseCase,
    this._removeFilmFromWatchlistUseCase,
    this._searchFilmUseCase,
  ) : super(FilmState.initial()) {
    on<FilmEvent>(_mapToEvent);
  }

  Future<void> _mapToEvent(FilmEvent events, Emitter<FilmState> emit) async {
    await events.map(
      fetchMainPageEvent: (event) async {
        await _handleFetchMainPageEvent(event, emit);
      },
      getTopRatedFilmsEvent: (event) async {
        await _handleGetTopRatedFilmsEvent(event, emit);
      },
      getNowPlayingFilmsEvent: (event) async {
        await _handleGetNowPlayingFilmsEvent(event, emit);
      },
      getPopularFilmsEvent: (event) async {
        await _handleGetPopularFilmsEvent(event, emit);
      },
      goToListPageEvent: (event) async {
        await _handleGoToListPageEvent(event, emit);
      },
      getRecommendationFilmsEvent: (event) async {
        await _handleGetRecommendationFilmsEvent(event, emit);
      },
      searchFilmsEvent: (event) async {
        await _handleSearchFilmsEvent(event, emit);
      },
      watchlistCheckEvent: (event) async =>
          await _handleWatchlistCheckEvent(event, emit),
      getWatchlistEvent: (event) async =>
          await _handleGetWatchlistEvent(event, emit),
      addToWatchlistEvent: (event) async =>
          await _handleAddToWatchlistEvent(event, emit),
      getHasExistWatchlistEvent: (event) async =>
          await _handleGetHasExistWatchlistEvent(event, emit),
      removeFilmFromWatchlistEvent: (event) async =>
          await _handleRemoveFilmFromWatchlistEvent(event, emit),
      changeHomeDrawerIndexEvent: (event) async =>
          await _handleChangeHomeTabEvent(event, emit),
      changeWatchlistTabIndexEvent: (event) async =>
          await _handleChangeWatchlistTabIndexEvent(event, emit),
      resetSearchEvent: (event) async =>
          await _handleResetSearchEvent(event, emit),
      getFilmReviews: (event) async => _handleGetFilmReviewsEvent(event, emit),
      getUpComingFilmsEvent: (event) async =>
          _handleGetUpComingFilmEvent(event, emit),
    );
  }

  Future<void> _handleFetchMainPageEvent(
    FetchMainPageEvent event,
    Emitter<FilmState> emit,
  ) async {
    // Get all movies
    add(const GetTopRatedFilmEvent(type: FilmType.movie));
    add(const GetPopularFilmsEvent(type: FilmType.movie));
    add(const GetNowPlayingFilmsEvent(type: FilmType.movie));
    add(const GetUpComingFilmEvent());

    // Get all TVs
    add(const GetTopRatedFilmEvent(type: FilmType.tv));
    add(const GetPopularFilmsEvent(type: FilmType.tv));
    add(const GetNowPlayingFilmsEvent(type: FilmType.tv));
  }

  Future<void> _handleGetTopRatedFilmsEvent(
    GetTopRatedFilmEvent event,
    Emitter<FilmState> emit,
  ) async {
    if (event.type.isMovieFilms()) {
      emit(state.copyWith(
        topRatedMovieFilmsState: const ViewState.loading(),
      ));
    }
    if (event.type.isTvFilms()) {
      emit(state.copyWith(
        topRatedTvFilmsState: const ViewState.loading(),
      ));
    }

    final result = await _getTopRatedFilmUseCase.call(event.type);

    result.when(
      success: (data) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            topRatedMovieFilmsState: const ViewState.success(),
            topRatedMovieFilms: data,
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            topRatedTvFilmsState: const ViewState.success(),
            topRatedTvFilms: data,
          ));
        }
      },
      error: (message, data, exception, stackTrace, statusCode) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            topRatedMovieFilmsState: const ViewState.failed(),
            topRatedMovieFilms: data ?? [],
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            topRatedTvFilmsState: const ViewState.failed(),
            topRatedTvFilms: data ?? [],
          ));
        }
      },
    );
  }

  Future<void> _handleGetNowPlayingFilmsEvent(
    GetNowPlayingFilmsEvent event,
    Emitter<FilmState> emit,
  ) async {
    if (event.type.isMovieFilms()) {
      emit(state.copyWith(
        nowPlayingMovieFilmsState: const ViewState.loading(),
      ));
    }
    if (event.type.isTvFilms()) {
      emit(state.copyWith(
        nowPlayingTvFilmsState: const ViewState.loading(),
      ));
    }

    final result = await _getNowPlayingFilmsUseCase.call(event.type);

    result.when(
      success: (data) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            nowPlayingMovieFilmsState: const ViewState.success(),
            nowPlayingMovieFilms: data,
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            nowPlayingTvFilmsState: const ViewState.success(),
            nowPlayingTvFilms: data,
          ));
        }
      },
      error: (message, data, exception, stackTrace, statusCode) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            nowPlayingMovieFilmsState: const ViewState.failed(),
            nowPlayingMovieFilms: data ?? [],
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            nowPlayingTvFilmsState: const ViewState.failed(),
            nowPlayingTvFilms: data ?? [],
          ));
        }
      },
    );
  }

  Future<void> _handleGetPopularFilmsEvent(
    GetPopularFilmsEvent event,
    Emitter<FilmState> emit,
  ) async {
    if (event.type.isMovieFilms()) {
      emit(state.copyWith(
        popularMovieFilmsState: const ViewState.loading(),
      ));
    }
    if (event.type.isTvFilms()) {
      emit(state.copyWith(
        popularTvFilmsState: const ViewState.loading(),
      ));
    }

    final result = await _getPopularFilmsUseCase.call(event.type);

    result.when(
      success: (data) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            popularMovieFilmsState: const ViewState.success(),
            popularMovieFilms: data,
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            popularTvFilmsState: const ViewState.success(),
            popularTvFilms: data,
          ));
        }
      },
      error: (message, data, exception, stackTrace, statusCode) {
        if (event.type.isMovieFilms()) {
          emit(state.copyWith(
            popularMovieFilmsState: const ViewState.failed(),
            popularMovieFilms: data ?? [],
          ));
        }

        if (event.type.isTvFilms()) {
          emit(state.copyWith(
            popularTvFilmsState: const ViewState.failed(),
            popularTvFilms: data ?? [],
          ));
        }
      },
    );
  }

  Future<void> _handleGetRecommendationFilmsEvent(
    GetRecommendationFilmsEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(
      recommendationFilmsState: const ViewState.loading(),
    ));

    final result = await _getRecommendationFilmUseCase.call(
      event.type,
      event.id,
    );

    result.when(
      success: (data) {
        emit(state.copyWith(
          recommendationFilmsState: const ViewState.success(),
          recommendationFilms: data,
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          recommendationFilmsState: const ViewState.failed(),
          recommendationFilms: data ?? [],
        ));
      },
    );
  }

  Future<void> _handleSearchFilmsEvent(
    SearchFilmsEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(
      searchFilmsState: const ViewState.loading(),
    ));

    final result = await _searchFilmUseCase.call(event.type, event.query);

    result.when(
      success: (data) {
        emit(state.copyWith(
          searchFilmsState: const ViewState.success(),
          searchFilms: data,
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          searchFilmsState: const ViewState.failed(),
          searchFilms: data ?? [],
        ));
      },
    );
  }

  Future<void> _handleResetSearchEvent(
      ResetSearchEvent event, Emitter<FilmState> emit) async {
    emit(state.copyWith(
      searchFilmsState: const ViewStateInitial(),
      searchFilms: [],
    ));
  }

  Future<void> _handleGoToListPageEvent(
    GoToListPageEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(
      listFilmsPerCategory: event.films,
      filmSectionType: event.filmSectionType,
      listFilmsPerCategoryType: event.filmType,
    ));
  }

  Future<void> _handleWatchlistCheckEvent(
    WatchlistCheckEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(
      isExistedInWatchlist: state.watchlistFilms.contains(event.thisFilm),
    ));
  }

  Future<void> _handleGetWatchlistEvent(
    GetWatchlistEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(
      watchlistFilmsState: const ViewState.loading(),
    ));

    final result = await _getWatchlistFilmsUseCase.call(event.type);

    result.when(
      success: (data) {
        emit(state.copyWith(
          watchlistFilmsState: const ViewState.success(),
          watchlistFilms: data,
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          watchlistFilmsState: const ViewState.failed(),
          watchlistFilms: data ?? [],
        ));
      },
    );
  }

  Future<void> _handleAddToWatchlistEvent(
    AddToWatchlistEvent event,
    Emitter<FilmState> emit,
  ) async {
    await _addFilmToWatchlistUseCase.call(event.type, event.film);
  }

  Future<void> _handleGetHasExistWatchlistEvent(
    GetHasExistWatchlistEvent event,
    Emitter<FilmState> emit,
  ) async {
    final result = await _getHasExistInWatchlistUseCase.call(
      event.type,
      event.id,
    );

    result.when(
      success: (status) => emit(
        state.copyWith(isExistedInWatchlist: status),
      ),
      error: (message, data, exception, stackTrace, error) {
        emit(state.copyWith(isExistedInWatchlist: false));
      },
    );
  }

  Future<void> _handleRemoveFilmFromWatchlistEvent(
    RemoveFilmFromWatchlistEvent event,
    Emitter<FilmState> emit,
  ) async {
    await _removeFilmFromWatchlistUseCase.call(
      event.type,
      event.id,
    );
  }

  Future<void> _handleChangeHomeTabEvent(
    ChangeHomeDrawerIndexEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(homePageDrawerIndex: event.index));
  }

  Future<void> _handleChangeWatchlistTabIndexEvent(
    ChangeWatchlistTabIndexEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(watchlistTabIndex: event.index));
  }

  Future<void> _handleGetFilmReviewsEvent(
    GetFilmReviewsEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(reviewState: const ViewState.loading()));

    final result =
        await _getFilmReviewsUseCase.call(event.type, event.id, event.page);

    result.when(
      success: (data) => emit(
        state.copyWith(
          reviewState: const ViewState.success(),
          reviewFilm: data,
        ),
      ),
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          reviewState: const ViewState.failed(),
          reviewFilm: const ReviewEntity(
            id: 0,
            page: 0,
            results: [],
            totalPages: 0,
            totalResults: 0,
          ),
        ));
      },
    );
  }

  Future<void> _handleGetUpComingFilmEvent(
    GetUpComingFilmEvent event,
    Emitter<FilmState> emit,
  ) async {
    emit(state.copyWith(upComingMovieFilmsState: const ViewState.loading()));

    final result = await _getUpComingMoviesUseCase.call();

    result.when(
      success: (data) {
        emit(state.copyWith(
          upComingMovieFilmsState: const ViewState.success(),
          upComingMovieFilms: data,
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          upComingMovieFilmsState: const ViewState.failed(),
          upComingMovieFilms: data ?? [],
        ));
      },
    );
  }
}
