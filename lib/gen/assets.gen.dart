/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDbsGen {
  const $AssetsDbsGen();

  /// File path: assets/dbs/world_cities.db
  String get worldCities => 'assets/dbs/world_cities.db';

  /// List of all assets
  List<String> get values => [worldCities];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Montserrat-Bold.ttf
  String get montserratBold => 'assets/fonts/Montserrat-Bold.ttf';

  /// File path: assets/fonts/Montserrat-ExtraBold.ttf
  String get montserratExtraBold => 'assets/fonts/Montserrat-ExtraBold.ttf';

  /// File path: assets/fonts/Montserrat-Medium.ttf
  String get montserratMedium => 'assets/fonts/Montserrat-Medium.ttf';

  /// File path: assets/fonts/Montserrat-SemiBold.ttf
  String get montserratSemiBold => 'assets/fonts/Montserrat-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    montserratBold,
    montserratExtraBold,
    montserratMedium,
    montserratSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/iualumni_icon.png
  AssetGenImage get iualumniIcon =>
      const AssetGenImage('assets/icons/iualumni_icon.png');

  /// File path: assets/icons/iualumni_icon_trans.png
  AssetGenImage get iualumniIconTrans =>
      const AssetGenImage('assets/icons/iualumni_icon_trans.png');

  /// Directory path: assets/icons/map
  $AssetsIconsMapGen get map => const $AssetsIconsMapGen();

  /// File path: assets/icons/map_point.png
  AssetGenImage get mapPoint =>
      const AssetGenImage('assets/icons/map_point.png');

  /// List of all assets
  List<AssetGenImage> get values => [iualumniIcon, iualumniIconTrans, mapPoint];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alumni.svg
  String get alumni => 'assets/images/alumni.svg';

  /// List of all assets
  List<String> get values => [alumni];
}

class $AssetsIconsMapGen {
  const $AssetsIconsMapGen();

  /// File path: assets/icons/map/profile_pin.png
  AssetGenImage get profilePin =>
      const AssetGenImage('assets/icons/map/profile_pin.png');

  /// List of all assets
  List<AssetGenImage> get values => [profilePin];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsDbsGen dbs = $AssetsDbsGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
