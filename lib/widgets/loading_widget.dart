import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:movies/theme/app_colors.dart';
import 'package:movies/utils/size_config.dart';

callProgressDialog(context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      title: Center(
        child: Container(
            color: Colors.transparent,
            height: SizeConfig.imageSizeMultiplier * 15,
            width: SizeConfig.imageSizeMultiplier * 15,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [AppColors.colorPrimary],
            )),
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

Widget loadingDialog({double size}) {
  return Center(
    child: Container(
        color: Colors.transparent,
        height: size ?? SizeConfig.imageSizeMultiplier * 15,
        width: size ?? SizeConfig.imageSizeMultiplier * 15,
        child: LoadingIndicator(
          indicatorType: Indicator.ballScale,
          colors: [AppColors.colorPrimary],
        )),
  );
}
