import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_model.g.dart';

@JsonSerializable()
class FilmModel {
  final int id;
  final String? name;
  final String? title;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final String overview;

  const FilmModel({
    required this.id,
    this.name,
    this.title,
    required this.voteAverage,
    required this.posterPath,
    required this.overview,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) =>
      _$FilmModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilmModelToJson(this);
}
