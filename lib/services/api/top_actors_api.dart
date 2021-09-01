import 'package:movies/constants/constants.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/models/top_actors_model.dart';
import 'package:movies/pages/top_actors.dart';

import 'api_url.dart';
import 'base_dio_api.dart';

class TopActorsApi extends BaseDioApi {
  String reqUrl = ApiUrl.popularPerson;
  int page;

  TopActorsApi({this.page = 1});

  Future callTopActorsApi() async {
    reqUrl += "?api_key=${Constants.movieApiKey}&language=en-US&page=$page";
    var response = await getRequest();
    return response;
  }

  @override
  Map<String, dynamic> getResponse(Map<String, dynamic> response) {
    List<TopActorsModel> topActors = [];

    for (var actor in response["data"]["results"]) {
      topActors.add(TopActorsModel.fromJson(actor));
    }

    return {"data": topActors, "status": true};
  }
}
