import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';

import '../database/app_database.dart';

Future<AppDatabase> openDatabase() async {
  final dir = await getApplicationDocumentsDirectory();

  final file = File(p.join(dir.path, AssetPaths.assetDbName));

  return AppDatabase(NativeDatabase.createInBackground(file));
}
