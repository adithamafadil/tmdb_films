import 'package:injectable/injectable.dart';
import 'package:tmdb_films/data/models/review/review_model.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';

@lazySingleton
class ReviewMapper {
  final ReviewResultMapper _resultMapper;

  const ReviewMapper(this._resultMapper);

  ReviewEntity modelToEntity(ReviewModel model) => ReviewEntity(
        id: model.id,
        page: model.page,
        results: model.results.map((e) {
          return _resultMapper.modelToEntity(e);
        }).toList(),
        totalPages: model.totalPages,
        totalResults: model.totalResults,
      );
}

@lazySingleton
class ReviewResultMapper {
  final AuthorDetailMapper _authorDetailMapper;

  const ReviewResultMapper(this._authorDetailMapper);

  ReviewResultEntity modelToEntity(ReviewResultModel model) =>
      ReviewResultEntity(
        author: model.author,
        authorDetail: _authorDetailMapper.modelToEntity(model.authorDetail),
        content: model.content,
        createdAt: model.createdAt,
        id: model.id,
        updatedAt: model.updatedAt,
        url: model.url,
      );
}

@lazySingleton
class AuthorDetailMapper {
  AuthorDetailEntity modelToEntity(AuthorDetailModel model) =>
      AuthorDetailEntity(
        name: model.name,
        username: model.username,
        avatarPath: model.avatarPath ?? '',
        rating: model.rating ?? 0.0,
      );
}
