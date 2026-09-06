import 'package:drift/wasm.dart';
import 'package:flutter/services.dart';

import '../../../../app/constants/asset_paths.dart';
import '../database/app_database.dart';

Future<AppDatabase> openDatabase() async {
  /// loading data from asset DB
  final dbData = await rootBundle.load(
    '${AssetPaths.assetDbPath}${AssetPaths.assetDbName}',
  );

  final result = await WasmDatabase.open(
    databaseName: AssetPaths.assetDbName,
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
    initializeDatabase: () async {
      /// loading data from asset DB
      return Uint8List.view(
        dbData.buffer,
        dbData.offsetInBytes,
        dbData.lengthInBytes,
      );
    },
  );

  return AppDatabase(result.resolvedExecutor);
}
