import 'dart:async';

import 'package:flutter/widgets.dart';

Future<void> preloadAsset(String asset) async {
  assert(asset.isNotEmpty);
  if (asset.isEmpty) {
    return;
  }
  final assetImage = AssetImage(asset);
  final imageStream = assetImage.resolve(ImageConfiguration.empty);
  final completer = Completer<void>();
  final listener = ImageStreamListener(
    (_, __) => completer.complete(),
    onError: completer.completeError,
  );
  imageStream.addListener(listener);
  return completer.future
      .whenComplete(() => imageStream.removeListener(listener));
}
