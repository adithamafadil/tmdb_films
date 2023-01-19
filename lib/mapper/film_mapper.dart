import 'package:tmdb_films/data/dto/film/film_dto.dart';
import 'package:tmdb_films/domain/entities/film/film_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilmMapper {
  FilmEntity dtoToEntity(FilmDTO? dto) => FilmEntity(
        id: dto?.id ?? -1,
        title: (dto?.name ?? dto?.title) ?? '',
        voteAverage: dto?.voteAverage ?? 0,
        posterPath: dto?.posterPath ?? '',
        overview: dto?.overview ?? '',
      );

  FilmDTO entityToDto(FilmEntity entity) => FilmDTO(
        id: entity.id,
        title: entity.title,
        name: entity.title,
        voteAverage: entity.voteAverage,
        posterPath: entity.posterPath,
        overview: entity.overview,
      );
}
