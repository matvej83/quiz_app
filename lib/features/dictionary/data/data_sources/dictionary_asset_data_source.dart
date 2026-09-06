import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../app/constants/asset_paths.dart';

@lazySingleton
class DictionaryAssetDataSource {
  Future<String> getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();

    return p.join(dir.path, AssetPaths.assetDbName);
  }

  Future<bool> databaseExists() async {
    final path = await getDatabasePath();

    return File(path).exists();
  }

  Future<void> copyDatabaseFromAssets(String assetName) async {
    final path = await getDatabasePath();

    final file = File(path);

    final data = await rootBundle.load(AssetPaths.assetDbPath + assetName);

    final bytes = data.buffer.asUint8List();

    await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> deleteDatabase() async {
    final path = await getDatabasePath();

    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
