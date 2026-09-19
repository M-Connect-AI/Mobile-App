// dart format width=120

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/bg_card_blue.svg
  SvgGenImage get bgCardBlue => const SvgGenImage('assets/image/bg_card_blue.svg');

  /// File path: assets/image/bg_card_eis.svg
  SvgGenImage get bgCardEis => const SvgGenImage('assets/image/bg_card_eis.svg');

  /// File path: assets/image/bg_card_pink.svg
  SvgGenImage get bgCardPink => const SvgGenImage('assets/image/bg_card_pink.svg');

  /// File path: assets/image/bg_card_purple.svg
  SvgGenImage get bgCardPurple => const SvgGenImage('assets/image/bg_card_purple.svg');

  /// File path: assets/image/ic_calendar.svg
  SvgGenImage get icCalendar => const SvgGenImage('assets/image/ic_calendar.svg');

  /// File path: assets/image/ic_check.svg
  SvgGenImage get icCheck => const SvgGenImage('assets/image/ic_check.svg');

  /// File path: assets/image/ic_eis_msb.svg
  SvgGenImage get icEisMsb => const SvgGenImage('assets/image/ic_eis_msb.svg');

  /// File path: assets/image/ic_external_link.svg
  SvgGenImage get icExternalLink => const SvgGenImage('assets/image/ic_external_link.svg');

  /// File path: assets/image/ic_late_and_soon_absent.svg
  SvgGenImage get icLateAndSoonAbsent => const SvgGenImage('assets/image/ic_late_and_soon_absent.svg');

  /// File path: assets/image/ic_other_file.svg
  SvgGenImage get icOtherFile => const SvgGenImage('assets/image/ic_other_file.svg');

  /// File path: assets/image/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/image/logo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    bgCardBlue,
    bgCardEis,
    bgCardPink,
    bgCardPurple,
    icCalendar,
    icCheck,
    icEisMsb,
    icExternalLink,
    icLateAndSoonAbsent,
    icOtherFile,
    logo,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsImageGen image = $AssetsImageGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
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
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package);
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
