import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:chatbot_project/common/components/app_text_style.dart';
import 'package:chatbot_project/common/components/irh_button.dart';
import 'package:chatbot_project/common/extensions/responsive_extension.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/domain/model/chat_thread.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_chat_ai_cubit.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatThreadHistory extends StatelessWidget {
  const ChatThreadHistory({super.key, this.maxItems});

  /// Số lượng thread tối đa hiển thị. `null` = hiển thị tất cả.
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeChatAiCubit, HomeChatAiState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.threads != current.threads,
      builder: (context, state) {
        return switch (state.status) {
          ChatThreadStatus.initial ||
          ChatThreadStatus.loading => const _HistoryLoading(),
          ChatThreadStatus.failure => const _HistoryFailure(),
          ChatThreadStatus.success when state.threads.isEmpty =>
            const _HistoryEmpty(),
          ChatThreadStatus.success => _HistoryList(
            threads: state.threads,
            maxItems: maxItems,
          ),
        };
      },
    );
  }
}

class _HistoryLoading extends StatelessWidget {
  const _HistoryLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.height,
      child: Center(
        child: SizedBox(
          width: 24.width,
          height: 24.width,
          child: CircularProgressIndicator(
            strokeWidth: 4.width,
            color: context.appColorScheme.iconBrand,
          ),
        ),
      ),
    );
  }
}

class _HistoryFailure extends StatelessWidget {
  const _HistoryFailure();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Column(
      children: [
        Text(
          strings.historyLoadError,
          textAlign: TextAlign.center,
          style: AppTextStyle.r12.copyWith(
            color: context.appColorScheme.textError,
          ),
        ),
        8.height.heightBox,
        IrhTextButton(
          label: strings.retry,
          onPressed: context.read<HomeChatAiCubit>().loadThreads,
        ),
      ],
    ).paddingSymmetric(vertical: 16.height);
  }
}

class _HistoryEmpty extends StatelessWidget {
  const _HistoryEmpty();

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).historyEmpty,
      textAlign: TextAlign.center,
      style: AppTextStyle.r12.copyWith(
        color: context.appColorScheme.textSecondary,
      ),
    ).paddingSymmetric(vertical: 24.height);
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({required this.threads, this.maxItems});

  final List<ChatThread> threads;
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final accentColors = [
      colors.iconBrand,
      colors.textSuccess,
      colors.textBrand,
      colors.iconSecondary,
    ];
    final sortedThreads = [...threads]
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final visibleThreads = maxItems != null && sortedThreads.length > maxItems!
        ? sortedThreads.sublist(0, maxItems!)
        : sortedThreads;
    return Column(
      children: [
        for (var index = 0; index < visibleThreads.length; index++)
          _HistoryItem(
            key: ValueKey(visibleThreads[index].threadId),
            thread: visibleThreads[index],
            accentColor: accentColors[index % accentColors.length],
            showDivider: index < visibleThreads.length - 1,
          ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({
    super.key,
    required this.thread,
    required this.accentColor,
    required this.showDivider,
  });

  final ChatThread thread;
  final Color accentColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final updatedDate = DateFormat(
      'dd/MM/yyyy',
    ).format(thread.updatedAt.toLocal());
    return Column(
      children: [
        CupertinoButton(
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(vertical: 8.height),
          onPressed: () => ChatRoute(
            threadId: thread.threadId,
            title: thread.title,
          ).push(context),
          child: Row(
            children: [
              _HistoryMark(color: accentColor),
              12.width.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thread.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.m16.copyWith(color: colors.textPrimary),
                  ),
                  4.height.heightBox,
                  Text(
                    S
                        .of(context)
                        .threadPreviewWithDate(thread.preview, updatedDate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.r12.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ).expanded(),
              8.width.widthBox,
              Text(
                '›',
                style: AppTextStyle.b24.copyWith(color: colors.iconSecondary),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1.height,
            color: colors.borderTertiary,
          ).paddingOnly(left: 52.width),
      ],
    );
  }
}

class _HistoryMark extends StatelessWidget {
  const _HistoryMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.width,
      height: 40.width,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 16.width,
        height: 16.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
