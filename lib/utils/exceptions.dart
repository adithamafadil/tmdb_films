abstract class FilmExceptions implements Exception {
  final String message;
  final int statusCode;
  final dynamic error;
  final StackTrace stackTrace;

  const FilmExceptions(
    this.error,
    this.message,
    this.statusCode,
    this.stackTrace,
  );
}

class FilmException implements FilmExceptions {
  final dynamic exError;
  final String exMessage;
  final int exStatusCode;
  final StackTrace exStackTrace;

  const FilmException({
    required this.exStatusCode,
    required this.exMessage,
    required this.exError,
    required this.exStackTrace,
  });

  @override
  get error => exError;

  @override
  String get message => exMessage;

  @override
  int get statusCode => exStatusCode;

  @override
  StackTrace get stackTrace => exStackTrace;
}
