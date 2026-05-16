import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/router/app_router.dart';

import '../theme/cubit/cubit.dart';
import '../theme/cubit/state.dart';
import 'di/injection.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = getIt<AppRouter>();
  final themeCubit = getIt<ThemeCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => themeCubit..loadTheme())],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Quiz App',
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
            theme: state.theme,
          );
        },
      ),
    );
  }
}
