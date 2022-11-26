import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TmdbFilmsDrawer extends StatelessWidget {
  final FilmType type;
  const TmdbFilmsDrawer({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<FilmBloc, FilmState>(
        builder: (context, state) {
          return Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                ),
                accountName: Text('Nonton Kuy'),
                accountEmail: Text(''),
              ),
              ListTile(
                leading: const Icon(Icons.movie_outlined),
                title: const Text('Movies'),
                onTap: () {
                  context
                      .read<FilmBloc>()
                      .add(const ChangeHomeDrawerIndexEvent(index: 0));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.tv_outlined),
                title: const Text('TV'),
                onTap: () {
                  context
                      .read<FilmBloc>()
                      .add(const ChangeHomeDrawerIndexEvent(index: 1));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt_outlined),
                title: const Text('Watchlist'),
                onTap: () {
                  context.read<FilmBloc>()
                    ..add(const GetWatchlistEvent(type: FilmType.movie))
                    ..add(const ChangeWatchlistTabIndexEvent(index: 0))
                    ..add(const ChangeHomeDrawerIndexEvent(index: 2));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
