import 'package:freezed_annotation/freezed_annotation.dart';
part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final int id;
  final int page;
  final List<ReviewResultModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const ReviewModel({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ReviewResultModel {
  final String author;
  @JsonKey(name: 'author_details')
  final AuthorDetailModel authorDetail;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String id;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final String url;
  const ReviewResultModel({
    required this.author,
    required this.authorDetail,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory ReviewResultModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResultModelToJson(this);
}

@JsonSerializable()
class AuthorDetailModel {
  final String name;
  final String username;
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;
  final double? rating;

  const AuthorDetailModel({
    this.avatarPath,
    required this.name,
    this.rating,
    required this.username,
  });

  factory AuthorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailModelToJson(this);
}
