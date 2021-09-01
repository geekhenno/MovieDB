import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/pages/movie_details.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/services/api/search_movies_api.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/app_bar_widget.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  MovieProvider _movieProvider;

  Future<void> _callSearchMovies(String query) async {
    var response =
        await SearchMoviesApi(page: 1, query: query).callSearchMoviesApi();
    print("response $response");
    if (response["status"]) {
      _movieProvider.setSearchMovies(response["data"]);
      return;
    }
    _movieProvider.setSearchMovies([]);
  }

  @override
  void initState() {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _movieProvider.clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _searchMovies = _movieProvider.searchMovies;

    return Scaffold(
      appBar: AppBarWidget(
        titleWidget: TextField(
            onChanged: (value) {
              _callSearchMovies(value);
            },
            textInputAction: TextInputAction.next,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: AppColors.white),
            keyboardType: TextInputType.name,
            cursorColor: AppColors.white60,
            autofocus: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white60),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: SizeConfig.imageSizeMultiplier * 5),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.heightMultiplier * 2),
              hintText: "Search",
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: AppColors.white60),
            )),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _searchMovies.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                      movie: _searchMovies[index],
                      tag: "${_searchMovies[index].id}search",
                    ),
                  ));
            },
            child: Hero(
              tag: "${_searchMovies[index].id}search",
              child: NetworkImageWidget(
                imageUrl:
                    "${Constants.imagePrefix}${_searchMovies[index].posterPath}",
              ),
            ),
          );
        },
      ),
    );
  }
}
