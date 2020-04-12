import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension AppImages on String {
  SvgPicture toSvgPicture({
    Key key,
    Map<String, String> headers,
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    bool matchTextDirection = false,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder placeholderBuilder,
    Color color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String semanticsLabel,
    bool excludeFromSemantics = false,
  }) {
    final defaultDomain = "https://dirumahaja.miloo.id/";
    final domainSplit = this.split(defaultDomain);
    final assetPath = domainSplit.length > 1 ? domainSplit[1] : this;
    
    return SvgPicture.network(
      'https://dirumahaja-challenge.web.app/' + assetPath,
      key: key,
      headers: headers,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
    );
  }

  Widget toPngImage({
    Key key,
    ImageWidgetBuilder imageBuilder,
    PlaceholderWidgetBuilder placeholder,
    LoadingErrorWidgetBuilder errorWidget,
    Duration fadeOutDuration = const Duration(milliseconds: 1000),
    Curve fadeOutCurve = Curves.easeOut,
    Duration fadeInDuration = const Duration(milliseconds: 500),
    Curve fadeInCurve = Curves.easeIn,
    double width,
    double height,
    BoxFit fit,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    Map<String, String> httpHeaders,
    BaseCacheManager cacheManager,
    bool useOldImageOnUrlChange = false,
    Color color,
    FilterQuality filterQuality = FilterQuality.low,
    BlendMode colorBlendMode,
    Duration placeholderFadeInDuration,
  }) {
    final defaultDomain = "https://dirumahaja.miloo.id/";
    final domainSplit = this.split(defaultDomain);
    final assetPath = domainSplit.length > 1 ? domainSplit[1] : this;

    return CachedNetworkImage(
      key: key,
      imageUrl: 'https://dirumahaja-challenge.web.app/' + assetPath,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      httpHeaders: httpHeaders,
      cacheManager: cacheManager,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      color: color,
      filterQuality: filterQuality,
      colorBlendMode: colorBlendMode,
      placeholderFadeInDuration: placeholderFadeInDuration,
    );
  }

  // svg
  static final bellSvg = 'assets/img/app/svg/bell.svg';
  static final helpSvg = 'assets/img/app/svg/help.svg';
  static final pinSvg = 'assets/img/app/svg/pin.svg';
  static final energySvg = 'assets/img/app/svg/energy.svg';
  static final nightShadeSvg = 'assets/img/app/svg/shade-night.svg';
  static final noonShadeSvg = 'assets/img/app/svg/shade-night.svg';
  static final assestmentSvg = 'assets/img/app/svg/assestment.svg';
  static final tearSvg = 'assets/img/app/svg/tear.svg';
  static final happySvg = 'assets/img/app/svg/happy.svg';

  // png
  static final homeBgPng = 'assets/img/app/png/home-bg.png';
  static final homeBgSmallPng = 'assets/img/app/png/home-bg-small.png';
  static final homeBgMediumPng = 'assets/img/app/png/home-bg-medium.png';
  static final cloudBgPng = 'assets/img/app/png/cloud-bg.png';
  static final cloudBg2Png = 'assets/img/app/png/cloud-bg-2.png';
  static final heroPng = 'assets/img/app/png/hero.png';
  static final productivePng = 'assets/img/app/png/productive.png';
  static final playstorePng = 'assets/img/app/png/playstore.png';
  static final appstorePng = 'assets/img/app/png/appstore.png';
  static final milooLogoPng = 'assets/img/app/png/miloo-logo.png';
}
