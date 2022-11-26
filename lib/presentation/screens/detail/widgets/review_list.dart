import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_films/domain/entities/review/review_entity.dart';
import 'package:tmdb_films/presentation/blocs/film/film_bloc.dart';
import 'package:tmdb_films/presentation/widgets/image_loader.dart';
import 'package:tmdb_films/utils/enum.dart';

class ReviewList extends StatelessWidget {
  final ReviewEntity review;
  final FilmType type;

  const ReviewList({super.key, required this.review, required this.type});

  @override
  Widget build(BuildContext context) {
    final reviewList = review.results;
    final totalPage = review.totalPages;
    final isEmpty = reviewList.isEmpty;

    return isEmpty
        ? const Center(child: Text('Tidak Ada Review'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Reviews'),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: reviewList.length,
                itemBuilder: (context, index) {
                  final review = reviewList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(99),
                                  child: ImageLoader(
                                    imagePath: review.authorDetail.avatarPath,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(review.authorDetail.name),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(review.content),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  totalPage,
                  (index) => PageIndicator(
                    page: index + 1,
                    isActivePage: (index + 1) == review.page,
                    filmId: review.id,
                    type: type,
                  ),
                ),
              ),
            ],
          );
  }
}

class PageIndicator extends StatelessWidget {
  final int page;
  final bool isActivePage;
  final int filmId;
  final FilmType type;
  const PageIndicator({
    super.key,
    required this.page,
    required this.isActivePage,
    required this.filmId,
    required this.type,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: isActivePage
            ? null
            : () {
                context.read<FilmBloc>().add(GetFilmReviewsEvent(
                      type: type,
                      id: filmId,
                      page: page,
                    ));
              },
        child: Card(
          color: isActivePage ? Colors.white : null,
          child: SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '$page',
                  style: TextStyle(
                    color: isActivePage ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
