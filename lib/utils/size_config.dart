import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum DeviceType { SM, MD, LG }

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  static DeviceType deviceType;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;

      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;

      isPortrait = false;
      isMobilePortrait = false;
    }

    if (_screenHeight <= 667) {
      deviceType = DeviceType.SM;
    } else if (_screenHeight > 667 && _screenHeight <= 1000) {
      deviceType = DeviceType.MD;
    } else {
      deviceType = DeviceType.LG;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    print("_screenHeight :$_screenHeight");
    print("device type  : $deviceType");
  }
}
