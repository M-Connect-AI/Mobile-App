import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:chatbot_project/common/components/app_text_style.dart';
import 'package:chatbot_project/common/components/irh_button.dart';
import 'package:chatbot_project/common/extensions/responsive_extension.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/chat/widgets/chat_input.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_chat_ai_cubit.dart';
import 'package:chatbot_project/presentation/pages/home/widgets/chat_thread_history.dart';
import 'package:chatbot_project/presentation/pages/home/widgets/home_back_button.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeChatAiPage extends StatelessWidget {
  const HomeChatAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeChatAiCubit(context.read<ChatThreadRepository>())..loadThreads(),
      child: const _HomeChatAiView(),
    );
  }
}

class _HomeChatAiView extends StatelessWidget {
  const _HomeChatAiView();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      body: SafeArea(
        child: Column(
          children: [
            const _ChatDashboard().expanded(),
            Container(
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                border: Border(top: BorderSide(color: colors.borderTertiary)),
              ),
              child: ChatInput.launcher(
                key: const Key('home-chat-input'),
                onTap: () => const ChatRoute().push(context),
              ).paddingSymmetric(horizontal: 20.width, vertical: 12.height),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatDashboard extends StatelessWidget {
  const _ChatDashboard();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DashboardHeader(),
          24.height.heightBox,
          Text(
            S.of(context).chatDashboardSlogan,
            style: AppTextStyle.b28.copyWith(
              color: context.appColorScheme.textPrimary,
              height: 1.16,
            ),
          ),
          24.height.heightBox,
          const _PromptSuggestions(),
          28.height.heightBox,
          const _HistorySection(),
          20.height.heightBox,
        ],
      ).paddingSymmetric(horizontal: 20.width, vertical: 16.height),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HomeBackButton(
          key: const Key('home-chat-back-button'),
          semanticLabel: S.of(context).backToHome,
        ),
      ],
    );
  }
}

class _PromptSuggestions extends StatelessWidget {
  const _PromptSuggestions();

  void _openChat(BuildContext context, String prompt) {
    ChatRoute(
      initialMessage: prompt,
      autoSendInitialMessage: true,
    ).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return SizedBox(
      height: 132.height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _SuggestionCard(
            key: const Key('leave-request-suggestion'),
            label: strings.leaveRequestSuggestion,
            backgroundColor: Color.lerp(
              colors.surfaceSecondary,
              colors.iconBrand,
              .18,
            )!,
            onPressed: () => _openChat(context, strings.leaveRequestSuggestion),
          ),
          12.width.widthBox,
          _SuggestionCard(
            key: const Key('leave-list-suggestion'),
            label: strings.leaveListSuggestion,
            backgroundColor: Color.lerp(
              colors.surfaceSecondary,
              colors.textSuccess,
              .16,
            )!,
            onPressed: () => _openChat(context, strings.leaveListSuggestion),
          ),
          12.width.widthBox,
          _SuggestionCard(
            key: const Key('leave-balance-suggestion'),
            label: strings.leaveBalanceSuggestion,
            backgroundColor: Color.lerp(
              colors.surfaceTemary,
              colors.textBrand,
              .12,
            )!,
            onPressed: () => _openChat(context, strings.leaveBalanceSuggestion),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return SizedBox(
      width: 152.width,
      child: CupertinoButton(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(20),
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.borderSecondary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.sm16.copyWith(
                  color: colors.textPrimary,
                  height: 1.24,
                ),
              ).expanded(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '↗',
                  style: AppTextStyle.b24.copyWith(color: colors.textPrimary),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
        ),
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  const _HistorySection();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.borderSecondary),
        boxShadow: [
          BoxShadow(
            color: colors.iconPrimary.withValues(alpha: .06),
            blurRadius: 24.width,
            offset: Offset(0, 8.height),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                strings.history,
                style: AppTextStyle.b20.copyWith(color: colors.textPrimary),
              ).expanded(),
              IrhTextButton(
                key: const Key('chat-history-see-all'),
                label: strings.seeAll,
                onPressed: () => const ChatHistoryRoute().push(context),
              ),
            ],
          ),
          8.height.heightBox,
          const ChatThreadHistory(),
        ],
      ).paddingAll(16.width),
    );
  }
}
