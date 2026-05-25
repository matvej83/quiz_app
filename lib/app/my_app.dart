import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/router/app_router.dart';
import 'package:quiz_app/features/profile/presentation/cubit/cubit.dart';

import '../features/history/presentation/cubit/cubit.dart';
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
  final profileCubit = getIt<ProfileCubit>();
  final historyCubit = getIt<HistoryCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit..loadTheme()),
        BlocProvider(create: (_) => profileCubit),
        BlocProvider(create: (_) => historyCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Quiz App',
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
