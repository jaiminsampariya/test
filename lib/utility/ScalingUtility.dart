import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScalingUtility {
  ScalingUtility({required this.context});
  final BuildContext context;
  Size figmaPhonePort = const Size(360, 640);
  Size desktopViewPort = const Size(1366, 768);
  late Size currentDeviceSize;
  late Orientation orientation;
  late double devicePixelRatio;
  late double fw;
  late double fh;

  void setPhoneViewport(Size size) {
    figmaPhonePort = size;
  }

  void setCurrentDeviceSize() {
    orientation = MediaQuery.of(context).orientation;
    currentDeviceSize = MediaQuery.of(context).size;
    if (!kIsWeb && orientation == Orientation.landscape) {
      double landscapeWidth = currentDeviceSize.width / 2;
      double landscapeHeight = currentDeviceSize.height / 2;
      currentDeviceSize = Size(landscapeWidth, landscapeHeight);
    }
    fh = MediaQuery.of(context).size.height;
    fw = currentDeviceSize.width;

    if (!kIsWeb &&
        (currentDeviceSize.height / currentDeviceSize.width) !=
            (figmaPhonePort.height / figmaPhonePort.width)) {
      currentDeviceSize = Size(
          currentDeviceSize.width,
          (figmaPhonePort.height /
              figmaPhonePort.width *
              currentDeviceSize.width));
    }
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  EdgeInsetsGeometry getPadding(
      {double? all,
      double? left,
      double? top,
      double? right,
      double? bottom,
      double? horizontal,
      double? vertical}) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    } else if (horizontal != null || vertical != null) {
      left = horizontal ?? 0;
      right = horizontal ?? 0;
      top = vertical ?? 0;
      bottom = vertical ?? 0;
    }
    return EdgeInsets.only(
      left: getScaledWidth(
        left ?? 0,
      ),
      top: getScaledHeight(
        top ?? 0,
      ),
      right: getScaledWidth(
        right ?? 0,
      ),
      bottom: getScaledHeight(
        bottom ?? 0,
      ),
    );
  }

  EdgeInsetsGeometry getMargin(
      {double? all,
      double? left,
      double? top,
      double? right,
      double? bottom,
      double? horizontal,
      double? vertical}) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    } else if (horizontal != null || vertical != null) {
      left = horizontal ?? 0;
      right = horizontal ?? 0;
      top = vertical ?? 0;
      bottom = vertical ?? 0;
    }
    return EdgeInsets.only(
      left: getScaledWidth(
        left ?? 0,
      ),
      top: getScaledHeight(
        top ?? 0,
      ),
      right: getScaledWidth(
        right ?? 0,
      ),
      bottom: getScaledHeight(
        bottom ?? 0,
      ),
    );
  }

  double get fullWidth => currentDeviceSize.width;
  double get fullHeight => currentDeviceSize.height;
  double get heightRatio => kIsWeb
      ? fh / (desktopViewPort.height)
      : !kIsWeb && currentDeviceSize.width < 500
          ? currentDeviceSize.height / (figmaPhonePort.height)
          : currentDeviceSize.height / 1024;

  double get widthRatio => kIsWeb
      ? fw / (desktopViewPort.width)
      : !kIsWeb && currentDeviceSize.width < 500
          ? currentDeviceSize.width / (figmaPhonePort.width)
          : fw / (desktopViewPort.height);

  double get fontRatio => min(heightRatio, heightRatio);

  double getScaledHeight(num value) => (heightRatio * value).ceilToDouble();

  double getScaledWidth(num value) => (widthRatio * value).ceilToDouble();

  double getScaledFont(num value) => (fontRatio * value).ceilToDouble();
}
