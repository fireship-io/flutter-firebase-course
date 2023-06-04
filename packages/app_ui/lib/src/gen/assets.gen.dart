/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************
library;

import 'package:flutter/widgets.dart';

class $AssetsCoversGen {
  const $AssetsCoversGen();

  AssetGenImage get angular => const AssetGenImage('assets/covers/angular.png');
  AssetGenImage get cloudFunctions =>
      const AssetGenImage('assets/covers/cloud-functions.png');
  AssetGenImage get defaultCover =>
      const AssetGenImage('assets/covers/default-cover.png');
  AssetGenImage get firebase =>
      const AssetGenImage('assets/covers/firebase.png');
  AssetGenImage get firestore =>
      const AssetGenImage('assets/covers/firestore.png');
  AssetGenImage get flutterLayout =>
      const AssetGenImage('assets/covers/flutter-layout.png');
  AssetGenImage get flutter => const AssetGenImage('assets/covers/flutter.png');
  AssetGenImage get js => const AssetGenImage('assets/covers/js.png');
  AssetGenImage get rxjs => const AssetGenImage('assets/covers/rxjs.png');
  AssetGenImage get ts => const AssetGenImage('assets/covers/ts.png');
}

class Assets {
  Assets._();

  static const AssetGenImage congrats = AssetGenImage('assets/congrats.gif');
  static const $AssetsCoversGen covers = $AssetsCoversGen();
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(super.assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
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
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
