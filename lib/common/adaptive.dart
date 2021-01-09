import 'package:flutter/material.dart';

class SizeFit {
  static SizeFit _instance;
  static const int defaultWidth = 1920;
  static const int defaultHeight = 1080;

  num uiWidthPx;
  num uiHeightPx;

  bool allowFontScaling;

  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;

  SizeFit._();

  factory SizeFit() {
    return _instance;
  }

  static void init(
    BuildContext context, {
    num width = defaultWidth,
    num height = defaultHeight,
    bool allowFontScaling = false,
  }) {
    if (_instance == null) {
      _instance = SizeFit._();
    }
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;

    MediaQueryData mediaQuery = MediaQuery.of(context);

    // 缩放因子
    _pixelRatio = mediaQuery.devicePixelRatio;

    // 设备宽度
    _screenWidth = mediaQuery.size.width;

    // 设备高度
    _screenHeight = mediaQuery.size.height;

    // 设备顶部安全高度
    _statusBarHeight = mediaQuery.padding.top;

    // 设备底部安全高度
    _bottomBarHeight = mediaQuery.padding.bottom;

    // 系统字体的缩放比例
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static double get textScaleFactor => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  static double get screenHeightPx => _screenWidth * _pixelRatio;

  static double get statusBarHeight => _statusBarHeight;

  static double get bottomBarHeight => _bottomBarHeight;

  double get scaleWidth => _screenWidth / uiWidthPx;

  double get scaleHeight => _screenHeight / uiHeightPx;

  double get scaleText => scaleWidth;

  // 宽度适配
  num setWidth(num width) => width * scaleWidth;

  // 高度适配
  num setHeight(num height) => height * scaleHeight;

  // 字体大小适配 allowFontScalingSelt是否根据系统字体变化
  num setSp(num fontSize, {bool allowFontScalingSelt}) =>
      allowFontScalingSelt == null
          ? (allowFontScaling
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor))
          : (allowFontScalingSelt
              ? (fontSize * scaleText)
              : ((fontSize * scaleText) / _textScaleFactor));
}
