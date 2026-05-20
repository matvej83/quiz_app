import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:quiz_app/app/constants/app_constants.dart';

@singleton
class TtsService {
  final FlutterTts _tts = FlutterTts();

  Future<void> init() async {
    await _tts.setLanguage(AppConstants.enLocale);

    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(5.0);
    await _tts.setPitch(1.0);

    await _tts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;

    await stop();

    await _tts.speak(text);
  }

  Future<void> setLanguage(String language) async {
    try {
      await _tts.setLanguage(language);
    } on Exception catch (e) {
      log(e.toString());
      await _tts.setLanguage(AppConstants.enLocale);
    }
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
