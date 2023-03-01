import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class MovieSearchEvent {}

class MovieSearchStartedEvent extends MovieSearchEvent {
  final String query;

  MovieSearchStartedEvent({required this.query});
}

class MovieSelectedEvent extends MovieSearchEvent {
  final String imdbID;

  MovieSelectedEvent({required this.imdbID});
}

