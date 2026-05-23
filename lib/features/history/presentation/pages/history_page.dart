import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/features/history/presentation/widgets/history_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
        centerTitle: true,
        leading: BackButton(
          style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: const HistoryList(),
    );
  }
}
