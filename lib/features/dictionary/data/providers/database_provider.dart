import 'dart:io';

import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../app/constants/app_constants.dart';
import '../database/app_database.dart';

@lazySingleton
class DatabaseProvider {
  Future<AppDatabase> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    final file = File(p.join(dir.path, AppConstants.assetDbName));

    return AppDatabase(NativeDatabase.createInBackground(file));
  }
}
