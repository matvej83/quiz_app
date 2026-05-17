import 'package:quiz_app/app/constants/app_constants.dart';
import 'package:quiz_app/core/error/failure.dart';

class AppUtils {
  static String? parseFailureMessage(Failure failure) {
    if (failure is CacheFailure) {
      return AppConstants.cacheError;
    }
    if (failure is CacheFailure) {
      return AppConstants.assetError;
    }
    if (failure is UnknownFailure) {
      return failure.message;
    }
    return null;
  }
}
