List<MoviesListResponseModel> moviesListResponseModelFromJson(
    List<dynamic> jsonList) {
  return jsonList
      .map((json) => MoviesListResponseModel.fromJson(json))
      .toList();
}

class MoviesListResponseModel {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MoviesListResponseModel({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory MoviesListResponseModel.fromJson(Map<String, dynamic> json) {
    return MoviesListResponseModel(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      type: json['Type'],
      poster: json['Poster'],
    );
  }
}
