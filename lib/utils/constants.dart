class Constants {
  const Constants();

  static String imageUrl = 'https://image.tmdb.org/t/p/w500';
  static String largeImageUrl =
      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';
}

enum FilmSections {
  nowPlaying,
  topRated,
  popular,
  upComing;

  bool get isNowPlaying => this == nowPlaying;
  bool get isTopRated => this == topRated;
  bool get ispopular => this == popular;

  @override
  String toString() {
    switch (this) {
      case nowPlaying:
        return 'Now Playing';
      case topRated:
        return 'Top Rated';
      case popular:
        return 'Popular';
      case upComing:
        return 'Up Coming';
      default:
        return '';
    }
  }
}

class APICore {
  const APICore();

  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = '0be47f8a233f2718d99d0c366369f1f8';
}
