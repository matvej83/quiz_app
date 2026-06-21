export 'database_provider_stub.dart'
    if (dart.library.io) 'database_provider_native.dart'
    if (dart.library.js_interop) 'database_provider_web.dart';
