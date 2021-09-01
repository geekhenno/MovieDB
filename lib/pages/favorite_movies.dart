import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/pages/movie_details.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class FavoriteMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _favoriteMovies = _movieProvider.favoriteMovies;

    return _favoriteMovies.isEmpty
        ? SizedBox()
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 1,
                    horizontal: SizeConfig.heightMultiplier * 1,
                  ),
                  child: TitleWidget(
                    title: "Favorite Movies",
                  ),
                ),
                Container(
                  height: SizeConfig.heightMultiplier * 30,
                  child: ListView.builder(
                    itemCount: _favoriteMovies.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                  movie: _favoriteMovies[index],
                                  tag: "${_favoriteMovies[index].id}favorite",
                                ),
                              ));
                        },
                        child: Hero(
                          tag: "${_favoriteMovies[index].id}favorite",
                          child: NetworkImageWidget(
                            imageUrl:
                                "${Constants.imagePrefix}${_favoriteMovies[index].posterPath}",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
