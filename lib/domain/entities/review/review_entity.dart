import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_entity.freezed.dart';

@freezed
class ReviewEntity with _$ReviewEntity {
  const factory ReviewEntity({
    required int id,
    required int page,
    required List<ReviewResultEntity> results,
    required int totalPages,
    required int totalResults,
  }) = _ReviewEntity;
}

@freezed
class ReviewResultEntity with _$ReviewResultEntity {
  const factory ReviewResultEntity({
    required String author,
    required AuthorDetailEntity authorDetail,
    required String content,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
    required String url,
  }) = _ReviewResultEntity;
}

@freezed
class AuthorDetailEntity with _$AuthorDetailEntity {
  const factory AuthorDetailEntity({
    required String name,
    required String username,
    required String avatarPath,
    required double rating,
  }) = _AuthorDetailEntitys;
}
