import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/constants/app_constants.dart';
import '../../dictionary/data/data_sources/dictionary_asset_data_source.dart';

@lazySingleton
class DictionaryService {
  DictionaryService(this.assetDataSource);

  final DictionaryAssetDataSource assetDataSource;

  Future<void> initialize() async {
    if (!kIsWeb) {
      final exists = await assetDataSource.databaseExists();

      if (!exists) {
        await assetDataSource.copyDatabaseFromAssets(AppConstants.assetDbName);
      }
    }
  }
}
