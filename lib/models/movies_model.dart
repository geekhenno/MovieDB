import 'package:movies/models/movie_model.dart';

class MoviesModel {
  int page;
  int totalPages;
  int totalResults;
  List<MovieModel> movies;

  MoviesModel({this.page, this.totalPages, this.totalResults, this.movies});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json["page"],
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
      movies: parseMovies(json),
    );
  }

  static List<MovieModel> parseMovies(json) {
    var list = json['results'] as List;
    List<MovieModel> movies =
        list.map((data) => MovieModel.fromJson(data)).toList();
    return movies;
  }
}
