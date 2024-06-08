/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/aml_logo.svg
  SvgGenImage get amlLogo => const SvgGenImage('assets/images/aml_logo.svg');

  /// File path: assets/images/dot.svg
  SvgGenImage get dot => const SvgGenImage('assets/images/dot.svg');

  /// File path: assets/images/ic_app_about_logo.jpeg
  AssetGenImage get icAppAboutLogo =>
      const AssetGenImage('assets/images/ic_app_about_logo.jpeg');

  /// File path: assets/images/ic_app_about_logo_no_bg.png
  AssetGenImage get icAppAboutLogoNoBg =>
      const AssetGenImage('assets/images/ic_app_about_logo_no_bg.png');

  /// File path: assets/images/ic_arrow_right.svg
  SvgGenImage get icArrowRight =>
      const SvgGenImage('assets/images/ic_arrow_right.svg');

  /// File path: assets/images/ic_ask.png
  AssetGenImage get icAsk => const AssetGenImage('assets/images/ic_ask.png');

  /// File path: assets/images/ic_back.svg
  SvgGenImage get icBack => const SvgGenImage('assets/images/ic_back.svg');

  /// File path: assets/images/ic_double_arrow.svg
  SvgGenImage get icDoubleArrow =>
      const SvgGenImage('assets/images/ic_double_arrow.svg');

  /// File path: assets/images/ic_eye.svg
  SvgGenImage get icEye => const SvgGenImage('assets/images/ic_eye.svg');

  /// File path: assets/images/ic_eye_off.svg
  SvgGenImage get icEyeOff => const SvgGenImage('assets/images/ic_eye_off.svg');

  /// File path: assets/images/ic_fp.svg
  SvgGenImage get icFp => const SvgGenImage('assets/images/ic_fp.svg');

  /// File path: assets/images/ic_gallery.svg
  SvgGenImage get icGallery =>
      const SvgGenImage('assets/images/ic_gallery.svg');

  /// File path: assets/images/ic_google.svg
  SvgGenImage get icGoogle => const SvgGenImage('assets/images/ic_google.svg');

  /// File path: assets/images/ic_idbi.png
  AssetGenImage get icIdbi => const AssetGenImage('assets/images/ic_idbi.png');

  /// File path: assets/images/ic_list.png
  AssetGenImage get icList => const AssetGenImage('assets/images/ic_list.png');

  /// File path: assets/images/ic_logo.jpeg
  AssetGenImage get icLogo => const AssetGenImage('assets/images/ic_logo.jpeg');

  /// File path: assets/images/ic_person.svg
  SvgGenImage get icPerson => const SvgGenImage('assets/images/ic_person.svg');

  /// File path: assets/images/ic_placeholder.png
  AssetGenImage get icPlaceholder =>
      const AssetGenImage('assets/images/ic_placeholder.png');

  /// File path: assets/images/login_secure.png
  AssetGenImage get loginSecure =>
      const AssetGenImage('assets/images/login_secure.png');

  /// File path: assets/images/ssl.svg
  SvgGenImage get ssl => const SvgGenImage('assets/images/ssl.svg');

  /// List of all assets
  List<dynamic> get values => [
        amlLogo,
        dot,
        icAppAboutLogo,
        icAppAboutLogoNoBg,
        icArrowRight,
        icAsk,
        icBack,
        icDoubleArrow,
        icEye,
        icEyeOff,
        icFp,
        icGallery,
        icGoogle,
        icIdbi,
        icList,
        icLogo,
        icPerson,
        icPlaceholder,
        loginSecure,
        ssl
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
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
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
