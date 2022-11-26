import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/widgets/film_card.dart';
import 'package:tmdb_films/utils/constants.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerCategoryScreen extends StatelessWidget {
  final FilmType type;
  final FilmSections filmSection;
  const PerCategoryScreen({
    Key? key,
    required this.type,
    required this.filmSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${filmSection.toString()} ${type.toString()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.listFilmsPerCategory.length,
              itemBuilder: (context, index) {
                final film = state.listFilmsPerCategory[index];
                return FilmCard(
                  cardType: FilmCardType.vertical,
                  film: film,
                  type: type,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
