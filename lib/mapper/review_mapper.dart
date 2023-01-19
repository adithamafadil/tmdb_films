import 'package:injectable/injectable.dart';
import 'package:tmdb_films/data/dto/review/review_dto.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';

@lazySingleton
class ReviewMapper {
  final ReviewResultMapper _resultMapper;

  const ReviewMapper(this._resultMapper);

  ReviewEntity dtoToEntity(ReviewDTO? dto) => ReviewEntity(
        id: dto?.id ?? -1,
        page: dto?.page ?? 0,
        results: dto?.results?.map((e) {
              return _resultMapper.dtoToEntity(e);
            }).toList() ??
            [],
        totalPages: dto?.totalPages ?? 0,
        totalResults: dto?.totalResults ?? 0,
      );
}

@lazySingleton
class ReviewResultMapper {
  final AuthorDetailMapper _authorDetailMapper;

  const ReviewResultMapper(this._authorDetailMapper);

  ReviewResultEntity dtoToEntity(ReviewResultDTO? dto) => ReviewResultEntity(
        author: dto?.author ?? '',
        authorDetail: _authorDetailMapper.dtoToEntity(dto?.authorDetail),
        content: dto?.content ?? '',
        createdAt: dto?.createdAt ?? DateTime.now(),
        id: dto?.id ?? '',
        updatedAt: dto?.updatedAt ?? DateTime.now(),
        url: dto?.url ?? '',
      );
}

@lazySingleton
class AuthorDetailMapper {
  AuthorDetailEntity dtoToEntity(AuthorDetailDTO? dto) => AuthorDetailEntity(
        name: dto?.name ?? '',
        username: dto?.username ?? '',
        avatarPath: dto?.avatarPath ?? '',
        rating: dto?.rating ?? 0.0,
      );
}
