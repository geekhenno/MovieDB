import 'package:movies/constants/constants.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movies_model.dart';

import 'api_url.dart';
import 'base_dio_api.dart';

class SearchMoviesApi extends BaseDioApi {
  String reqUrl = ApiUrl.searchMovie;
  int page;
  String query;

  SearchMoviesApi({this.page = 1, this.query = ""});

  Future callSearchMoviesApi() async {
    reqUrl +=
        "?api_key=${Constants.movieApiKey}&language=en-US&page=$page&query=$query";
    var response = await getRequest();
    return response;
  }

  @override
  Map<String, dynamic> getResponse(Map<String, dynamic> response) {
    List<MovieModel> movies = [];

    for (var movie in response["data"]["results"])
      movies.add(MovieModel.fromJson(movie));

    return {"data": movies, "status": true};
  }
}
