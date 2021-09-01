import 'package:flutter/material.dart';
import 'package:movies/theme/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget appBar;
  final List<Widget> actions;
  final Widget leading;
  final Widget titleWidget;
  final double leadingWidth;
  final Color backgroundColor;
  final double elevation;
  final bool automaticallyImplyLeading;

  const AppBarWidget(
      {Key key,
      this.title,
      this.appBar,
      this.actions,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.titleWidget,
      this.backgroundColor,
      this.elevation = 0,
      this.leadingWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.colorPrimary,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      brightness: Brightness.dark,
      leadingWidth: leadingWidth ?? AppBar().leadingWidth,
      leading: leading,
      centerTitle: true,
      title: title == null
          ? titleWidget
          : FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.white),
              ),
            ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(appBar ?? AppBar().preferredSize.height);
}
