import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:provider/provider.dart';

import 'movie_details.dart';

class LatestMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _upComingMovies = _movieProvider.upComingMovies.movies.take(10);
    return CarouselSlider(
      options: CarouselOptions(
        height: SizeConfig.heightMultiplier * 20,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      items: _upComingMovies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(
                        movie: movie,
                        tag: "${movie.id}latest",
                      ),
                    ));
              },
              child: Hero(
                tag: "${movie.id}latest",
                child: NetworkImageWidget(
                  boxFit: BoxFit.fitWidth,
                  imageUrl: "${Constants.imagePrefix}${movie.backdropPath}",
                  width: SizeConfig.widthMultiplier * 80,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
