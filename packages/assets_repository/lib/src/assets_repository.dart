import 'dart:convert';

import 'package:assets_repository/src/utils.dart';
import 'package:flutter/services.dart';

class AssetsRepository {
  Future<void> preloadAssets(String path) async {
    try {
      final pathNames = await _readAssetsPathName();
      final assets = pathNames.where((pathName) => pathName.startsWith(path));
      await Future.wait(assets.map(preloadAsset));
    } catch (_) {}
  }

  Future<Iterable<String>> _readAssetsPathName() async {
    final manifestRawJson = await rootBundle.loadString('AssetManifest.json');
    final manifestJson = json.decode(manifestRawJson) as Map<String, dynamic>;
    return manifestJson.keys;
  }
}
