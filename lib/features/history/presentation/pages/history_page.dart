import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_back_button.dart';
import 'package:quiz_app/core/presentation/widgets/app_dialog.dart';
import 'package:quiz_app/core/presentation/widgets/calendar.dart';
import 'package:quiz_app/features/history/presentation/cubit/cubit.dart';
import 'package:quiz_app/features/history/presentation/widgets/history_list.dart';

import '../cubit/state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HistoryCubit>();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('historyPage.screenName'.tr()),
        centerTitle: true,
        leading: const AppBackButton(),
        actions: [
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {
              final now = DateTime.now();
              cubit.loadMonthHistory(year: now.year, month: now.month);
              AppDialog.empty(
                context,
                content: Container(
                  margin: const .all(16.0),
                  constraints: BoxConstraints(
                    maxHeight: screenSize.height * 0.9,
                    maxWidth: screenSize.width - 32.0,
                  ),
                  child: BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      return AppCalendar(
                        specialDays: state.trainingDays,
                        onMonthChanged: (year, month) {
                          cubit.loadMonthHistory(year: year, month: month);
                        },
                      );
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: const HistoryList(),
    );
  }
}
