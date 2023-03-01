import 'package:movies_archive/data/provider/remote_provider/movie_detail_api.dart';
import '../model/movie/movie_response_model.dart';

class MovieDetailRepository {
  Future<MovieResponseModel?> getMovieDetailsData(String imdbID) async {
    final rawData = await MovieDetailApi.getMovieDetails(imdbID);
    if (rawData.statusCode >= 200 && rawData.statusCode <= 399) {
      return movieFromJson(rawData.body);
    } else {
      return null;
    }
  }
}
