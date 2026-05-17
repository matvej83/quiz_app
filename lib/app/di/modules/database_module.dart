import 'package:injectable/injectable.dart';

import '../../../features/dictionary/data/database/app_database.dart';
import '../../../features/dictionary/data/providers/database_provider.dart';

@module
abstract class DatabaseModule {
  @preResolve
  Future<AppDatabase> provideDatabase(DatabaseProvider provider) async {
    return provider.openDatabase();
  }
}
