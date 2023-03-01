import 'dart:convert';
import 'package:movies_archive/data/model/movies/movies_list_response_model.dart';
import 'package:movies_archive/data/provider/remote_provider/movies_list_api.dart';

class MoviesRepository {
  Future<List<MoviesListResponseModel>?> getMoviesData(String query) async {
    final rawData = await MoviesListApi.searchMovies(query);
    final decodedJson = jsonDecode(rawData.body);
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      return moviesListResponseModelFromJson(decodedJson['Search']);
    } else {
      return null;
    }
  }
}
