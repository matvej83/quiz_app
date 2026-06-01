import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/features/translation/data/models/translation_model.dart';

abstract class CatalogLocalDataSource {
  Future<List<TranslationModel>?> loadCatalog();
}

@LazySingleton(as: CatalogLocalDataSource)
class CatalogLocalDataSourceImpl implements CatalogLocalDataSource {
  CatalogLocalDataSourceImpl();

  @override
  Future<List<TranslationModel>?> loadCatalog() async {
    try {
      final jsonString = await rootBundle.loadString(AssetPaths.assetTextsPath);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return TranslationModel.fromList(jsonList);
    } on Exception catch (e) {
      log(e.toString());
      throw AssetException();
    }
  }
}
