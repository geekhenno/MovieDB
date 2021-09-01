import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/pages/movie_details.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class UpComingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _upComingMovies = _movieProvider.getMoviesByGenres();

    return _upComingMovies.isEmpty
        ? Center(
            child: TitleWidget(
              title: "Empty Movies",
              color: AppColors.colorPrimary,
            ),
          )
        : ListView.builder(
            itemCount: _upComingMovies.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movie: _upComingMovies[index],
                          tag: "${_upComingMovies[index].id}upcoming",
                        ),
                      ));
                },
                child: Hero(
                  tag: "${_upComingMovies[index].id}upcoming",
                  child: NetworkImageWidget(
                    imageUrl:
                        "${Constants.imagePrefix}${_upComingMovies[index].posterPath}",
                  ),
                ),
              );
            },
          );
  }
}
