import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/watch_list_tab.dart';
import 'package:tmdb_films/presentation/widgets/film_card.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Watchlist extends StatelessWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        final type =
            state.watchlistTabIndex == 1 ? FilmType.tv : FilmType.movie;
        return Column(
          children: [
            Row(
              children: [
                WatchlistTab(
                  label: 'Movie',
                  icon: Icons.movie_filter_outlined,
                  isActive: state.watchlistTabIndex == 0,
                  onTap: () {
                    context.read<FilmBloc>()
                      ..add(const ChangeWatchlistTabIndexEvent(index: 0))
                      ..add(const GetWatchlistEvent(type: FilmType.movie));
                  },
                ),
                const SizedBox(width: 16),
                WatchlistTab(
                  label: 'TV Series',
                  icon: Icons.tv_rounded,
                  isActive: state.watchlistTabIndex == 1,
                  onTap: () {
                    context.read<FilmBloc>()
                      ..add(const ChangeWatchlistTabIndexEvent(index: 1))
                      ..add(const GetWatchlistEvent(type: FilmType.tv));
                  },
                )
              ],
            ),
            const SizedBox(height: 16),
            state.watchlistFilmsState.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              failed: () => const Center(child: Text('Failed')),
              orElse: () => const Center(child: Text('Error')),
              success: () => ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.watchlistFilms.length,
                itemBuilder: (context, index) {
                  final item = state.watchlistFilms[index];
                  return FilmCard(
                    cardType: FilmCardType.vertical,
                    film: item,
                    type: type,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
