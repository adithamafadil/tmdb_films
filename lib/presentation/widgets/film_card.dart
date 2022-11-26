import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/detail/detail_screen.dart';
import 'package:tmdb_films/presentation/screens/detail/widgets/rating.dart';
import 'package:tmdb_films/presentation/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_films/utils/enum.dart';

enum FilmCardType {
  vertical,
  horizontal;

  bool get isVerticalCard => this == vertical;
}

class FilmCard extends StatelessWidget {
  final FilmCardType cardType;
  final FilmEntity film;
  final FilmType type;
  const FilmCard({
    super.key,
    required this.cardType,
    required this.film,
    required this.type,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context.read<FilmBloc>()
            ..add(GetWatchlistEvent(type: type))
            ..add(WatchlistCheckEvent(thisFilm: film))
            ..add(GetRecommendationFilmsEvent(type: type, id: film.id))
            ..add(GetFilmReviewsEvent(type: type, id: film.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(film: film, type: type),
            ),
          );
        },
        child: cardType.isVerticalCard
            ? FilmCardVertical(film: film)
            : FilmCardHorizontal(film: film),
      );
}

class FilmCardHorizontal extends StatelessWidget {
  final FilmEntity film;

  const FilmCardHorizontal({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: ImageLoader(imagePath: film.posterPath),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  film.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilmCardVertical extends StatelessWidget {
  final FilmEntity film;

  const FilmCardVertical({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: ImageLoader(imagePath: film.posterPath),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        film.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Rating(voteAverage: film.voteAverage),
                      const SizedBox(height: 8),
                      Text(
                        film.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
