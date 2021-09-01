import 'package:movies/constants/constants.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movies_model.dart';

import 'api_url.dart';
import 'base_dio_api.dart';

class UpComingMoviesApi extends BaseDioApi {
  String reqUrl = ApiUrl.upcomingMovies;
  int page;

  UpComingMoviesApi({this.page = 1});

  Future callUpComingMoviesApi() async {
    reqUrl += "?api_key=${Constants.movieApiKey}&language=en-US&page=$page";
    var response = await getRequest();
    return response;
  }

  @override
  Map<String, dynamic> getResponse(Map<String, dynamic> response) {
    MoviesModel upComingMoviesModel = MoviesModel.fromJson(response["data"]);

    return {"data": upComingMoviesModel, "status": true};
  }
}
