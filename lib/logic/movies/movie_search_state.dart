import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';
import '../../data/model/movie/movie_response_model.dart';
import '../../data/model/movies/movies_list_response_model.dart';

@immutable
abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object?> get props => [];
}

class MovieSearchInitialState extends MovieSearchState {
  const MovieSearchInitialState();

}

class MovieSearchLoadingState extends MovieSearchState{
  const MovieSearchLoadingState();

}

class MovieSearchSuccessState extends MovieSearchState{
  final List<MoviesListResponseModel>? movies;
  const MovieSearchSuccessState({this.movies});

  @override
  List<Object?> get props => [movies];
}

class MovieSearchFailureState extends MovieSearchState {
  final String errorMessage;
  const MovieSearchFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class MovieSelectedSuccessState extends MovieSearchState {
  final MovieResponseModel movie;

  const MovieSelectedSuccessState({required this.movie});

  @override
  List<Object?> get props => [movie];
}






