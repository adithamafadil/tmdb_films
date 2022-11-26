import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/film_label.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/film_list.dart';
import 'package:tmdb_films/presentation/screens/per_category/per_category_screen.dart';
import 'package:tmdb_films/utils/constants.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVList extends StatelessWidget {
  const TVList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilmLabel(
          label: FilmSections.nowPlaying.toString(),
          onTapSeeAll: () => _onTapSeeAll(context, FilmSections.nowPlaying),
        ),
        BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            return state.nowPlayingTvFilmsState.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              failed: () => const Center(child: Text('Failed')),
              orElse: () => const Center(child: Text('Error')),
              success: () => FilmList(
                type: FilmType.tv,
                films: state.nowPlayingTvFilms,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        FilmLabel(
          label: FilmSections.topRated.toString(),
          onTapSeeAll: () => _onTapSeeAll(context, FilmSections.topRated),
        ),
        BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            return state.topRatedTvFilmsState.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              failed: () => const Center(child: Text('Failed')),
              orElse: () => const Center(child: Text('Error')),
              success: () => FilmList(
                type: FilmType.tv,
                films: state.topRatedTvFilms,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        FilmLabel(
          label: FilmSections.popular.toString(),
          onTapSeeAll: () => _onTapSeeAll(context, FilmSections.popular),
        ),
        BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            return state.popularTvFilmsState.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              failed: () => const Center(child: Text('Failed')),
              orElse: () => const Center(child: Text('Error')),
              success: () => FilmList(
                type: FilmType.tv,
                films: state.popularTvFilms,
              ),
            );
          },
        ),
      ],
    );
  }

  void _onTapSeeAll(BuildContext context, FilmSections filmSection) {
    const type = FilmType.tv;
    films() {
      if (filmSection.isNowPlaying) {
        return context.read<FilmBloc>().state.nowPlayingTvFilms;
      } else if (filmSection.isTopRated) {
        return context.read<FilmBloc>().state.topRatedTvFilms;
      } else {
        return context.read<FilmBloc>().state.popularTvFilms;
      }
    }

    context.read<FilmBloc>().add(GoToListPageEvent(
          filmType: type,
          filmSectionType: filmSection,
          films: films(),
        ));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PerCategoryScreen(
            type: type,
            filmSection: filmSection,
          ),
        ));
  }
}
