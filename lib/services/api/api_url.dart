import 'package:movies/constants/constants.dart';

class ApiUrl {
  static final String baseURL = "https://api.themoviedb.org/3/";
  static final String upcomingMovies = baseURL + "movie/upcoming";
  static final String popularPerson = baseURL + "person/popular";
  static final String popularMovies = baseURL + "movie/popular";
  static final String genres = baseURL + "genre/movie/list";
  static final String searchMovie = baseURL + "search/movie";
}
