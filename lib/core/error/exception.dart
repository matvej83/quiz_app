abstract class AppException implements Exception {}

class UnknownException extends AppException {
  UnknownException(this.message);

  final String message;
}

class CacheException extends AppException {}

class AssetException extends AppException {}
