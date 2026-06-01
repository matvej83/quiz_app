import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/core/error/exception.dart';
import 'package:quiz_app/features/text_catalog/data/models/text_model.dart';

abstract class TextCatalogLocalDataSource {
  Future<List<TextModel>?> loadCatalog();
}

@LazySingleton(as: TextCatalogLocalDataSource)
class CatalogLocalDataSourceImpl implements TextCatalogLocalDataSource {
  CatalogLocalDataSourceImpl();

  @override
  Future<List<TextModel>?> loadCatalog() async {
    try {
      final jsonString = await rootBundle.loadString(AssetPaths.assetTextsPath);
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return TextModel.fromList(jsonList);
    } on Exception catch (e) {
      log(e.toString());
      throw AssetException();
    }
  }
}
