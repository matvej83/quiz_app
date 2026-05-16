import 'package:flutter/material.dart';

import '../widgets/theme_selector.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [ThemeSelector()]);
  }
}
