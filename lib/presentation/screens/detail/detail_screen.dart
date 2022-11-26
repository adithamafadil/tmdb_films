import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/detail/widgets/rating.dart';
import 'package:tmdb_films/presentation/screens/detail/widgets/recommendation_films.dart';
import 'package:tmdb_films/presentation/screens/detail/widgets/review_list.dart';
import 'package:tmdb_films/presentation/widgets/image_loader.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  final FilmEntity film;
  final FilmType type;
  const DetailScreen({Key? key, required this.film, required this.type})
      : super(key: key);

  void _onPress(BuildContext context, bool isExistedInWatchlist) {
    if (!isExistedInWatchlist) {
      context.read<FilmBloc>().add(AddToWatchlistEvent(type: type, film: film));
    } else {
      context
          .read<FilmBloc>()
          .add(RemoveFilmFromWatchlistEvent(type: type, id: film.id));
    }

    context.read<FilmBloc>()
      ..add(GetWatchlistEvent(type: type))
      ..add(WatchlistCheckEvent(thisFilm: film));
  }

  @override
  Widget build(BuildContext context) {
    bool isExistedInWatchlist =
        context.watch<FilmBloc>().state.isExistedInWatchlist;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ImageLoader(imagePath: film.posterPath),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: DraggableScrollableSheet(
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.black87,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5,
                              width: 80,
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Text(
                            film.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Rating(voteAverage: film.voteAverage),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _onPress(context, isExistedInWatchlist),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white30),
                              ),
                              icon: Icon(isExistedInWatchlist
                                  ? Icons.check
                                  : Icons.add),
                              label: Text(
                                '${isExistedInWatchlist ? 'Added' : 'Add'} To Watchlist',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('Overview'),
                          const SizedBox(height: 8),
                          Text(film.overview),
                          const SizedBox(height: 8),
                          RecommendationFilms(type: type),
                          const SizedBox(height: 16),
                          BlocBuilder<FilmBloc, FilmState>(
                            builder: (context, state) {
                              return state.reviewState.maybeWhen(
                                success: () => ReviewList(
                                  review: state.reviewFilm,
                                  type: type,
                                ),
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                failed: () =>
                                    const Center(child: Text('Failed')),
                                orElse: () =>
                                    const Center(child: Text('Error')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
