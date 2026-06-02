import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:quiz_app/core/error/failure.dart';

class AppUtils {
  static String? parseFailureMessage(Failure failure) {
    if (failure is CacheFailure) {
      return 'errors.cacheError'.tr();
    }
    if (failure is CacheFailure) {
      return 'errors.assetError'.tr();
    }
    if (failure is UnknownFailure) {
      return failure.message;
    }
    return null;
  }

  static Map<String, dynamic> parseJson(String text) {
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);

    if (match == null) {
      throw Exception('JSON not found in Gemini response');
    }

    final jsonString = match.group(0)!;

    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  static String parseError(String error) {
    String errorText = error;
    try {
      final json = parseJson(error);
      final code = json['code'];
      final status = json['status'];
      if (code == 503 && status == 'UNAVAILABLE') {
        errorText = 'errors.modelUnavailable'.tr();
      }
      log(error);
    } on Exception catch (e) {
      log(e.toString());
    }
    return errorText;
  }
}
