import 'package:movies/constants/constants.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movies_model.dart';

import 'api_url.dart';
import 'base_dio_api.dart';

class GenresApi extends BaseDioApi {
  String reqUrl = ApiUrl.genres;
  int page;

  GenresApi({this.page = 1});

  Future callGenresApi() async {
    reqUrl += "?api_key=${Constants.movieApiKey}&language=en-US&page=$page";
    var response = await getRequest();
    return response;
  }

  @override
  Map<String, dynamic> getResponse(Map<String, dynamic> response) {
    List<GenresModel> genresModel = [];

    for (var genre in response["data"]["genres"]) {
      genresModel.add(GenresModel.fromJson(genre));
    }

    return {"data": genresModel, "status": true};
  }
}
