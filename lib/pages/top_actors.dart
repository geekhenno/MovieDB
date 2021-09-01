import 'package:flutter/material.dart';
import 'package:movies/constants/constants.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/widgets/network_image_widget.dart';
import 'package:movies/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class TopActors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _topActors = _movieProvider.topActors;

    return ListView.builder(
      itemCount: _topActors.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return NetworkImageWidget(
          imageUrl: "${Constants.imagePrefix}${_topActors[index].profilePath}",
        );
      },
    );
  }
}
