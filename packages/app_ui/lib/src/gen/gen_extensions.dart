import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_ui/src/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

extension AssetGenImageExtensions on AssetImage {
  Future<void> preload() {
    final imageStream = resolve(ImageConfiguration.empty);
    final completer = Completer<Uint8List>();
    final listener = ImageStreamListener(
      (imageInfo, _) async {
        final byteData = await imageInfo.image.toByteData(
          format: ui.ImageByteFormat.png,
        );
        completer.complete(byteData?.buffer.asUint8List());
      },
      onError: completer.completeError,
    );
    imageStream.addListener(listener);
    return completer.future.whenComplete(
      () => imageStream.removeListener(listener),
    );
  }
}

final List<AssetGenImage> _covers = [
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
