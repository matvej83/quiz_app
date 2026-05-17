import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/app/router/app_routes.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          OutlinedButton(
            onPressed: () {
              context.go('${AppRoutes.tests}/${AppRoutes.translate}');
            },
            child: const Text('Перевод слов'),
          ),
        ],
      ),
    );
  }
}
