import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Object error) {
  if (error is CacheException) return CacheFailure();
  if (error is AssetException) return AssetFailure();
  if (error is GeminiException) return GeminiFailure();

  if (error is UnknownException) {
    return UnknownFailure(error.message);
  }

  return UnknownFailure(error.toString());
}
