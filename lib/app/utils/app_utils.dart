import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
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

    if (e is SocketException) {
      return 'errors.network.noInternet'.tr();
    }

    if (e is TimeoutException) {
      return 'errors.network.timeout'.tr();
    }

    if (e is HandshakeException) {
      return 'errors.network.sslError'.tr();
    }

    if (e is http.ClientException) {
      return 'errors.network.connectionError'.tr();
    }

    if (e is FormatException) {
      return 'errors.geminiErrors.formatException'.tr();
    }

    if (e is TypeError || e is NoSuchMethodError || e is RangeError) {
      return 'errors.geminiErrors.invalidResponse'.tr();
    }

    // HTTP codes

    if (errorLog.contains('400')) {
      return 'errors.geminiErrors.badRequest'.tr();
    }

    if (errorLog.contains('401')) {
      return 'errors.geminiErrors.unauthorized'.tr();
    }

    if (errorLog.contains('403')) {
      return 'errors.geminiErrors.permissionDenied'.tr();
    }

    if (errorLog.contains('404')) {
      return 'errors.geminiErrors.notFound'.tr();
    }

    if (errorLog.contains('408')) {
      return 'errors.network.timeout'.tr();
    }

    if (errorLog.contains('413')) {
      return 'errors.geminiErrors.requestTooLarge'.tr();
    }

    if (errorLog.contains('422')) {
      return 'errors.geminiErrors.invalidRequest'.tr();
    }

    if (errorLog.contains('429')) {
      return 'errors.geminiErrors.limitReached'.tr();
    }

    if (errorLog.contains('500')) {
      return 'errors.geminiErrors.internalServerError'.tr();
    }

    if (errorLog.contains('502') ||
        errorLog.contains('503') ||
        errorLog.contains('504')) {
      return 'errors.geminiErrors.serverUnavailable'.tr();
    }

    return 'errors.geminiErrors.unknownError'.tr();
  }
}
