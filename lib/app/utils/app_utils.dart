import 'dart:convert';

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

  static String parseGeminiError(Object e) {
    final errorLog = e.toString();
    String userMessage = 'errors.'.tr();

    if (errorLog.contains('503') || errorLog.contains('UNAVAILABLE')) {
      userMessage = 'errors.geminiErrors.serverUnavailable'.tr();
    } else if (errorLog.contains('429') ||
        errorLog.contains('RESOURCE_EXHAUSTED')) {
      userMessage = 'errors.geminiErrors.limitReached'.tr();
    } else if (errorLog.contains('403') ||
        errorLog.contains('PERMISSION_DENIED')) {
      userMessage = 'errors.geminiErrors.permissionDenied'.tr();
    } else if (e is FormatException) {
      userMessage = 'errors.geminiErrors.formatException'.tr();
    }
    return userMessage;
  }
}
