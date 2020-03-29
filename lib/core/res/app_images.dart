import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension AppImages on String {
  SvgPicture toSvgPicture({
    Key key,
    bool matchTextDirection = false,
    AssetBundle bundle,
    String package,
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder placeholderBuilder,
    Color color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String semanticsLabel,
    bool excludeFromSemantics = false,
  }) {
    return SvgPicture.asset(
      this,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
    );
  }

  Image toPngImage({
    Key key,
    AssetBundle bundle,
    ImageFrameBuilder frameBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double scale,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    String package,
    FilterQuality filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  }) {
    return Image.asset(
      this,
      frameBuilder: frameBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  // svg
  static final arrowLeftSvg = 'assets/svg/arrow-left.svg';
  static final bellSvg = 'assets/svg/bell.svg';
  static final helpSvg = 'assets/svg/help.svg';
  static final pinSvg = 'assets/svg/pin.svg';
  static final nightShadeSvg = 'assets/svg/shade-night.svg';
  static final noonShadeSvg = 'assets/svg/shade-night.svg';
  static final assestmentSvg = 'assets/svg/assestment.svg';

  // png
  static final homeBgPng = 'assets/png/home-bg.png';
  static final homeBgSmallPng = 'assets/png/home-bg-small.png';
  static final homeBgMediumPng = 'assets/png/home-bg-medium.png';
  static final cloudBgPng = 'assets/png/cloud-bg.png';
  static final cloudBg2Png = 'assets/png/cloud-bg-2.png';
  static final heroPng = 'assets/png/hero.png';
  static final productivePng = 'assets/png/productive.png';
}
