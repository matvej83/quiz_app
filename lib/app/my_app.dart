import 'package:flutter/material.dart';
import 'package:quiz_app/app/router/app_router.dart';

import 'di/injection.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quiz App',
      routerConfig: appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
