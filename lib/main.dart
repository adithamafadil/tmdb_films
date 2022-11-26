import 'package:tmdb_films/di/injection.dart';
import 'package:tmdb_films/domain/db/film_db_entity.dart';
import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Dependencies to be injected
  await configureDependencies();

  // Configure Local DB using Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FilmDbEntityAdapter());

  runApp(const TmdbFilmsApp());
}

class TmdbFilmsApp extends StatefulWidget {
  const TmdbFilmsApp({Key? key}) : super(key: key);

  @override
  State<TmdbFilmsApp> createState() => _TmdbFilmsAppState();
}

class _TmdbFilmsAppState extends State<TmdbFilmsApp> {
  late Box _boxLocalDbMovies;

  _openLocalDbBox() async =>
      _boxLocalDbMovies = await Hive.openBox('watchlist');

  _closeLocalDbBox() async => await _boxLocalDbMovies.close();

  @override
  void initState() {
    _openLocalDbBox();
    super.initState();
  }

  @override
  void dispose() {
    _closeLocalDbBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<FilmBloc>()..add(const FetchMainPageEvent()),
      child: MaterialApp(
        home: const SplashScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
