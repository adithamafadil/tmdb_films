import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/drawer.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/movie_list.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/tv_list.dart';
import 'package:tmdb_films/presentation/screens/home/widgets/watch_list.dart';
import 'package:tmdb_films/presentation/screens/search/search_page.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final Map<String, Widget> listHomeMenus = const {
    'Movie': MovieList(),
    'TV Series': TVList(),
    'Watchlist': Watchlist(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) => Text(
            listHomeMenus.keys.toList()[state.homePageDrawerIndex],
          ),
        ),
        actions: [
          if (context.read<FilmBloc>().state.homePageDrawerIndex < 2)
            IconButton(
              onPressed: () {
                context.read<FilmBloc>().add(const ResetSearchEvent());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(
                        type: FilmType.movie,
                      ),
                    ));
              },
              icon: const Icon(Icons.search),
            ),
        ],
      ),
      drawer: TmdbFilmsDrawer(
        type: context.watch<FilmBloc>().state.homePageDrawerIndex == 0
            ? FilmType.movie
            : FilmType.tv,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) =>
                listHomeMenus.values.toList()[state.homePageDrawerIndex],
          ),
        ),
      ),
    );
  }
}
