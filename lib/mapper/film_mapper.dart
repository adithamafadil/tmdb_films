import 'package:tmdb_films/data/models/film/film_model.dart';
import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilmMapper {
  FilmEntity modelToEntity(FilmModel? model) => FilmEntity(
        id: model?.id ?? -1,
        title: (model?.name ?? model?.title) ?? '',
        voteAverage: model?.voteAverage ?? 0,
        posterPath: model?.posterPath ?? '',
        overview: model?.overview ?? '',
      );

  FilmModel entityToModel(FilmEntity entity) => FilmModel(
        id: entity.id,
        title: entity.title,
        name: entity.title,
        voteAverage: entity.voteAverage,
        posterPath: entity.posterPath,
        overview: entity.overview,
      );
}
