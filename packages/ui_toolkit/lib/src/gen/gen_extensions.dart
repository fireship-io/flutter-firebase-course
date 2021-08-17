import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:ui_toolkit/src/gen/assets.gen.dart';

extension AssetGenImageExtensions on AssetImage {
  Future<void> preload() {
    final imageStream = resolve(ImageConfiguration.empty);
    final completer = Completer<void>();
    final listener = ImageStreamListener(
      (_, __) => completer.complete(),
      onError: completer.completeError,
    );
    imageStream.addListener(listener);
    return completer.future
        .whenComplete(() => imageStream.removeListener(listener));
  }
}

final _covers = [
  Assets.covers.angular,
  Assets.covers.cloudFunctions,
  Assets.covers.defaultCover,
  Assets.covers.firebase,
  Assets.covers.firestore,
  Assets.covers.flutter,
  Assets.covers.flutterLayout,
  Assets.covers.js,
  Assets.covers.rxjs,
  Assets.covers.ts,
];

extension $AssetsCoversGenExtensions on $AssetsCoversGen {
  Future<void> preload() =>
      Future.wait(_covers.map((assetImage) => assetImage.preload()));

  Image imageByName(String assetName) {
    final assetImage = _covers.firstWhere(
      (image) => image.assetName.endsWith(assetName),
      orElse: () => defaultCover,
    );
    return assetImage.image(key: Key(assetImage.keyName));
  }
}
