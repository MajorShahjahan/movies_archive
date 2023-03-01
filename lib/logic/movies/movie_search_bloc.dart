
import 'package:bloc/bloc.dart';
import 'package:movies_archive/data/repository/movie_detail_repository.dart';
import 'package:movies_archive/data/repository/movies_repository.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';


class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc() : super(const MovieSearchInitialState()) {
    on<MovieSelectedEvent>((event,emit) async{
      emit(const MovieSearchInitialState());
      final MovieDetailRepository repository = MovieDetailRepository();
      final result = await repository.getMovieDetailsData(event.imdbID);

      if(result == null){
        emit(const MovieSearchFailureState(errorMessage: "some thing went wrong"));
      }else{
        emit(MovieSearchLoadingState());
        emit(MovieSelectedSuccessState(movie: result));
      }

    });
    on<MovieSearchStartedEvent>((event, emit) async {
      emit(const MovieSearchInitialState());
      final MoviesRepository repository = MoviesRepository();
      final result = await repository.getMoviesData(event.query);
      if(result == null){
        emit(const MovieSearchFailureState(errorMessage: "some thing went wrong"));
      }else{
        emit(MovieSearchLoadingState());
        emit(MovieSearchSuccessState(movies: result));
      }
    });
  }
}
