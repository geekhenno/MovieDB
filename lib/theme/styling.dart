import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/utils/size_config.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const double buttonRadius = 15;
  static final TextTheme lightTextTheme = TextTheme(
    caption: _textStyle,
    subtitle1: _subTextStyle1,
    subtitle2: _subTextStyle2,
    headline1: _headTextStyle1,
    headline2: _headTextStyle2,
    headline3: _headTextStyle3,
  );

  static final TextStyle _textStyle = GoogleFonts.cairo(
    fontSize: SizeConfig.textMultiplier * 1.8,
    color: AppColors.colorPrimary,
  );

  static final TextStyle _subTextStyle1 = _textStyle.copyWith(
      fontSize: SizeConfig.textMultiplier * 1.5, color: AppColors.colorPrimary);
  static final TextStyle _subTextStyle2 = _textStyle.copyWith(
      fontSize: SizeConfig.textMultiplier * 1.3, color: AppColors.colorPrimary);

  static final TextStyle _headTextStyle1 = _textStyle.copyWith(
      fontSize: SizeConfig.textMultiplier * 2.6, color: AppColors.colorPrimary);
  static final TextStyle _headTextStyle2 = _textStyle.copyWith(
      fontSize: SizeConfig.textMultiplier * 2.3, color: AppColors.colorPrimary);
  static final TextStyle _headTextStyle3 = _textStyle.copyWith(
      fontSize: SizeConfig.textMultiplier * 2.0, color: AppColors.colorPrimary);
}
