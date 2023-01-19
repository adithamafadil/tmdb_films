import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_dto.g.dart';

@JsonSerializable()
class FilmDTO {
  final int id;
  final String? name;
  final String? title;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final String? overview;

  const FilmDTO({
    required this.id,
    this.name,
    this.title,
    this.voteAverage,
    this.posterPath,
    this.overview,
  });

  factory FilmDTO.fromJson(Map<String, dynamic> json) =>
      _$FilmDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FilmDTOToJson(this);
}
