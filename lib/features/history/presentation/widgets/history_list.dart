import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/presentation/widgets/app_loader.dart';

import '../../domain/entity/history_entity.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late HistoryCubit cubit;
  final _scrollController = ScrollController();

  bool isBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (isBottom(_scrollController)) {
      cubit.loadMoreHistory();
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<HistoryCubit>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        return state.isLoading
            ? const AppLoader()
            : state.history.isEmpty
            ? Center(child: Text('errors.noData'.tr()))
            : Stack(
                children: [
                  ListView.separated(
                    controller: _scrollController,
                    itemCount: state.history.length,
                    physics: const ClampingScrollPhysics(),
                    padding: const .symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      final item = state.history[index];
                      final currentDate = DateFormat(
                        'yyyy.MM.dd',
                        locale.languageCode,
                      ).format(item.saved);

                      final previousDate = index > 0
                          ? DateFormat(
                              'yyyy.MM.dd',
                              locale.languageCode,
                            ).format(state.history[index - 1].saved)
                          : null;

                      final shouldShowDate = currentDate != previousDate;
                      return Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          if (shouldShowDate)
                            Align(alignment: .center, child: Text(currentDate)),
                          HistoryItem(history: item),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                  ),
                  if (state.isShowLoader)
                    const CircularProgressIndicator.adaptive(),
                ],
              );
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.history});

  final HistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium;
    final time = DateFormat.Hm().format(history.saved);
    return Card(
      child: Padding(
        padding: const .all(8.0),
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: .start,
          children: [
            Text(
              '${'historyPage.testType'.tr()}: ${history.testType.name}',
              style: style,
            ),
            Text(
              '${'historyPage.questionCount'.tr()}: ${history.totalAnswers}',
              style: style,
            ),
            Text(
              '${'historyPage.correctAnswers'.tr()}: ${history.correctAnswers}',
              style: style,
            ),
            Text(time, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
