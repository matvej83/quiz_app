import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/di/injection.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  runApp(
    EasyLocalization(
      ignorePluralRules: false,
      supportedLocales: const [Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru', 'RU'),
      child: const MyApp(),
    ),
  );
}
