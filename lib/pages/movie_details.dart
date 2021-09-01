import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/app_bar_widget.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MovieDetails extends StatelessWidget {
  final MovieModel movie;
  final String tag;

  const MovieDetails({Key key, @required this.movie, this.tag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    List<GenresModel> _genres = _movieProvider.getGenresById(movie.genreIds);
    return Scaffold(
      appBar: AppBarWidget(
        title: movie.originalTitle,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: tag,
              child: Stack(
                children: [
                  NetworkImageWidget(
                    width: SizeConfig.widthMultiplier * 100,
                    height: SizeConfig.heightMultiplier * 70,
                    boxFit: BoxFit.cover,
                    imageUrl: "${Constants.imagePrefix}${movie.posterPath}",
                  ),
                  Positioned(
                    bottom: 0,
                    child: CupertinoButton(
                        child: Icon(
                          _movieProvider.isMovieExist(movie.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _movieProvider.handleFavoriteMovie(movie);
                        }),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CupertinoButton(
                        child: Icon(
                          Icons.share,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          Share.share(
                              "${Constants.imagePrefix}${movie.backdropPath}",
                              subject: movie.originalTitle);
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.heightMultiplier * 1),
              child: TextWidget(
                title: movie.overview,
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier * 5,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightMultiplier * 1,
                vertical: SizeConfig.heightMultiplier * 1,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _genres.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.colorPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.heightMultiplier * 1),
                      child: TextWidget(
                        title: _genres[index].name,
                        color: AppColors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.heightMultiplier * 2),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Release Date: ",
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          title: movie.releaseDate,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget(
                          title: "Vote Average: ",
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          title: "${movie.voteAverage}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
