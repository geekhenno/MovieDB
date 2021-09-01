import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/provider/movie_provider.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:provider/provider.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    final _genres = _movieProvider.genres;
    return ChipsChoice<int>.single(
      value: _movieProvider.selectedGenres,
      choiceStyle: C2ChoiceStyle(
          color: AppColors.colorPrimary, brightness: Brightness.dark),
      onChanged: (val) {
        if (val == _movieProvider.selectedGenres) {
          _movieProvider.clearFilter();
          return;
        }
        _movieProvider.updateSelectedGenres(val);
      },
      choiceItems: C2Choice.listFrom<int, GenresModel>(
        source: _genres,
        value: (i, v) => i,
        label: (i, v) => v.name,
      ),
    );
  }
}
