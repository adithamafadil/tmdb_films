import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:tmdb_films/presentation/widgets/film_card.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';

class FilmList extends StatelessWidget {
  final List<FilmEntity> films;
  final FilmType type;
  const FilmList({
    Key? key,
    required this.films,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: films.length >= 5 ? 5 : films.length,
        itemBuilder: (context, index) {
          final item = films[index];
          return FilmCard(
            cardType: FilmCardType.horizontal,
            film: item,
            type: type,
          );
        },
      ),
    );
  }
}
