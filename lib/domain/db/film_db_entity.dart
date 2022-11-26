import 'package:hive_flutter/hive_flutter.dart';

part 'film_db_entity.g.dart';

@HiveType(typeId: 1)
class FilmDbEntity extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String overview;
  @HiveField(3)
  late String? posterPath;
  @HiveField(4)
  late double voteAverage;
  @HiveField(5)
  late String type;
}
