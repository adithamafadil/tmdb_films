import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/widgets/film_card.dart';
import 'package:tmdb_films/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final FilmType type;
  const SearchScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search $type')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextField(
                onSubmitted: (query) {
                  context
                      .read<FilmBloc>()
                      .add(SearchFilmsEvent(type: type, query: query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search Movie',
                  prefixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              BlocBuilder<FilmBloc, FilmState>(
                builder: (context, state) {
                  return state.searchFilmsState.maybeWhen(
                    orElse: () => const SizedBox(
                        height: 300, child: Center(child: Text('Else'))),
                    failed: () => const SizedBox(
                        height: 300, child: Center(child: Text('Failed'))),
                    initial: () => const SizedBox(
                        height: 300,
                        child: Center(child: Text('Not yet searched'))),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: () => state.searchFilms.isEmpty
                        ? SizedBox(
                            height: 300,
                            child: Center(child: Text('$type not found')))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.searchFilms.length,
                            itemBuilder: (context, index) {
                              final film = state.searchFilms[index];
                              return FilmCard(
                                film: film,
                                cardType: FilmCardType.vertical,
                                type: type,
                              );
                            },
                          ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
