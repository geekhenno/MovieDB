import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/models/top_actors_model.dart';
import 'package:movies/pages/favorite_movies.dart';
import 'package:movies/pages/genres.dart';
import 'package:movies/pages/search_movies.dart';
import 'package:movies/pages/top_actors.dart';
import 'package:movies/pages/upcoming_movies.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/services/api/genres_api.dart';
import 'package:movies/services/api/popular_movies_api.dart';
import 'package:movies/services/api/top_actors_api.dart';
import 'package:movies/services/api/up_coming_movies_api.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/app_bar_widget.dart';
import 'package:movies/widgets/loading_widget.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/title_widget.dart';
import 'package:provider/provider.dart';

import 'latest_movies.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future _upcomingMoviesFuture;
  Future _genresFuture;
  Future _popularMovies;
  Future _topActors;
  MovieProvider _movieProvider;

  @override
  void initState() {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.initFavoriteMovies();
    _upcomingMoviesFuture = _callUpcomingMovies();
    _genresFuture = _callGenresFuture();
    _popularMovies = _callPopularMovies();
    _topActors = _callTopActors();
    super.initState();
  }

  Future<void> _callUpcomingMovies() async {
    var response = await UpComingMoviesApi(page: 1).callUpComingMoviesApi();
    if (response["status"]) {
      MoviesModel _upComingMovies = response["data"];
      _movieProvider.setUpComingMovies(_upComingMovies);
    }
  }

  Future<void> _callPopularMovies() async {
    var response = await PopularMoviesApi(page: 1).callPopularMoviesApi();
    if (response["status"]) {
      MoviesModel _popularMovies = response["data"];
      _movieProvider.setUpPopularMovies(_popularMovies);
    }
  }

  Future<void> _callTopActors() async {
    var response = await TopActorsApi(page: 1).callTopActorsApi();
    if (response["status"]) {
      List<TopActorsModel> _topActors = response["data"];
      _movieProvider.setTopActors(_topActors);
    }
  }

  Future<void> _callGenresFuture() async {
    var response = await GenresApi(page: 1).callGenresApi();
    if (response["status"]) {
      _movieProvider.setGenres(response["data"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Movies",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchMovies(),
                  ));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait(
            [_upcomingMoviesFuture, _genresFuture, _popularMovies, _topActors]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: loadingDialog());
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 1,
                      horizontal: SizeConfig.heightMultiplier * 1),
                  child: TitleWidget(
                    title: "Latest Movies",
                  ),
                ),
                LatestMovies(),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier * 1),
                  child: TitleWidget(
                    title: "Popular",
                  ),
                ),
                Genres(),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                    height: SizeConfig.heightMultiplier * 30,
                    child: UpComingMovies()),
                FavoriteMovies(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 1,
                      horizontal: SizeConfig.heightMultiplier * 1),
                  child: TitleWidget(
                    title: "Top Actors",
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightMultiplier * 1,
                    ),
                    height: SizeConfig.heightMultiplier * 30,
                    child: TopActors()),
              ],
            ),
          );
        },
      ),
    );
  }
}
