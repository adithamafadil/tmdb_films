import 'package:freezed_annotation/freezed_annotation.dart';
part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDTO {
  final int id;
  final int? page;
  final List<ReviewResultDTO>? results;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_results')
  final int? totalResults;

  const ReviewDTO({
    required this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDTOToJson(this);
}

@JsonSerializable()
class ReviewResultDTO {
  final String? author;
  @JsonKey(name: 'author_details')
  final AuthorDetailDTO? authorDetail;
  final String? content;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final String? id;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final String? url;
  const ReviewResultDTO({
    this.author,
    this.authorDetail,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory ReviewResultDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResultDTOToJson(this);
}

@JsonSerializable()
class AuthorDetailDTO {
  final String? name;
  final String? username;
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;
  final double? rating;

  const AuthorDetailDTO({
    this.avatarPath,
    this.name,
    this.rating,
    this.username,
  });

  factory AuthorDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDetailDTOToJson(this);
}
