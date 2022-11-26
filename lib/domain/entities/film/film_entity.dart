import 'package:freezed_annotation/freezed_annotation.dart';
part 'film_entity.freezed.dart';

@freezed
class FilmEntity with _$FilmEntity {
  factory FilmEntity({
    required int id,
    required String title,
    required double voteAverage,
    required String posterPath,
    required String overview,
  }) = _FilmEntity;
}
