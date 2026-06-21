import 'package:injectable/injectable.dart';

import '../database/app_database.dart';
import 'database_provider_bridge.dart' as platform;

@lazySingleton
class DatabaseProvider {
  Future<AppDatabase> openDatabase() async {
    return platform.openDatabase();
  }
}
