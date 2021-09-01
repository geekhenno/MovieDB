import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/size_config.dart';
import 'package:movies/widgets/loading_widget.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Color imageColor;
  final double height;
  final double width;
  final BoxFit boxFit;

  const NetworkImageWidget(
      {Key key,
      this.imageUrl,
      this.imageColor,
      this.height,
      this.width,
      this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        placeholder: (context, url) => loadingDialog(),
        errorWidget: (context, url, error) => Icon(
              Icons.error,
              size: SizeConfig.heightMultiplier * 3,
            ),
        height: height ?? SizeConfig.imageSizeMultiplier * 80,
        fit: boxFit ?? BoxFit.fitWidth,
        color: imageColor);
  }
}
