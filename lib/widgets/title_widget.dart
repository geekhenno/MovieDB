import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  final Color color;
  final TextDirection textDirection;
  final TextOverflow overflow;
  final double fontSize;

  const TitleWidget(
      {Key key,
      this.title,
      this.textAlign,
      this.color,
      this.textDirection,
      this.fontSize,
      this.overflow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2.copyWith(
          fontWeight: FontWeight.bold,
          color: color ?? AppColors.colorPrimary,
          fontSize: fontSize),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
