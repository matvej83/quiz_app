import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/features/dictionary/services/dictionary_service.dart';

import '../../features/dictionary/services/tts_service.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  await getIt<DictionaryService>().initialize();
  await getIt<TtsService>().init();
}
