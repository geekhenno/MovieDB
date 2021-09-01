import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/models/top_actors_model.dart';

class MovieProvider with ChangeNotifier {
  final _moviesBox = Hive.box<MovieModel>('movieBox');
  Map<String, MovieModel> _favoriteMoviesMap = Map();

  void initFavoriteMovies() {
    _favoriteMoviesMap.addAll(_moviesBox.toMap().cast<String, MovieModel>());
    _favoriteMovies.addAll(_favoriteMoviesMap.values.toList());
  }

  List<MovieModel> _favoriteMovies = [];
  List<MovieModel> _searchMovies = [];
  MoviesModel _upComingMovies = MoviesModel(movies: []);
  MoviesModel _popularMovies = MoviesModel(movies: []);
  List<GenresModel> _genres = [];
  List<TopActorsModel> _topActors = [];
  int _selectedGenres = -1;

  MoviesModel get upComingMovies => _upComingMovies;
  List<GenresModel> get genres => [..._genres];
  List<TopActorsModel> get topActors => [..._topActors];
  List<MovieModel> get favoriteMovies => [..._favoriteMovies.reversed];
  List<MovieModel> get searchMovies => [..._searchMovies];
  int get selectedGenres => _selectedGenres;

  void setUpComingMovies(MoviesModel upComingMovies) {
    _upComingMovies = upComingMovies;
    notifyListeners();
  }

  void setUpPopularMovies(MoviesModel popularMovies) {
    _popularMovies = popularMovies;
    notifyListeners();
  }

  void setSearchMovies(List<MovieModel> movies) {
    _searchMovies = movies;
    notifyListeners();
  }

  void setTopActors(List<TopActorsModel> topActors) {
    _topActors = topActors;
    notifyListeners();
  }

  void setGenres(List<GenresModel> genres) {
    _genres = genres;
    notifyListeners();
  }

  void updateSelectedGenres(int index) {
    _selectedGenres = index;
    notifyListeners();
  }

  void clearFilter() {
    _selectedGenres = -1;
    notifyListeners();
  }

  List<MovieModel> getMoviesByGenres() {
    if (_selectedGenres >= 0)
      return _popularMovies.movies
          .where((element) => element.genreIds
              .any((element) => element == _genres[_selectedGenres].id))
          .toList();

    return _popularMovies.movies;
  }

  List<GenresModel> getGenresById(List<int> ids) {
    return _genres.where((item) => ids.contains(item.id)).toList();
  }

  void handleFavoriteMovie(MovieModel movie) {
    if (!isMovieExist(movie.id)) {
      _favoriteMoviesMap.putIfAbsent(movie.id.toString(), () => movie);
      _favoriteMovies.add(movie);
      _moviesBox.put("${movie.id}", movie);
    } else {
      _moviesBox.delete(movie.id.toString());
      _favoriteMoviesMap.remove(movie.id.toString());
      _favoriteMovies.removeWhere((element) => element.id == movie.id);
    }
    notifyListeners();
  }

  void deleteMovieFromFavorite(int id) {
    _moviesBox.delete(id.toString());
    _favoriteMoviesMap.remove(id.toString());
    _favoriteMovies.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool isMovieExist(int id) {
    return _favoriteMoviesMap.containsKey(id.toString());
  }

  void clearSearch() {
    _searchMovies.clear();
  }
}
