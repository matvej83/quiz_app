import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/constants/asset_paths.dart';
import 'package:quiz_app/features/profile/presentation/cubit/cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        cubit.loadProfile();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset(AssetPaths.splashLogo)),
    );
  }
}
