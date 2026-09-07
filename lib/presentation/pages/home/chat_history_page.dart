import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:chatbot_project/common/components/app_text_style.dart';
import 'package:chatbot_project/common/extensions/responsive_extension.dart';
import 'package:chatbot_project/common/themes/theme_extensions/app_color_scheme.dart';
import 'package:chatbot_project/domain/repository/chat_thread_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/presentation/pages/home/bloc/home_chat_ai_cubit.dart';
import 'package:chatbot_project/presentation/pages/home/widgets/chat_thread_history.dart';
import 'package:chatbot_project/presentation/pages/home/widgets/home_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/credential_repository.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeChatAiCubit(
        context.read<ChatThreadRepository>(),
        context.read<CredentialRepository>(),
      )..loadThreads(),
      child: const _ChatHistoryView(),
    );
  }
}

class _ChatHistoryView extends StatelessWidget {
  const _ChatHistoryView();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HomeBackButton(
                  key: const Key('chat-history-back-button'),
                  semanticLabel: S.of(context).backToChatDashboard,
                ),
                12.width.widthBox,
                Text(
                  S.of(context).chatHistoryTitle,
                  style: AppTextStyle.b24.copyWith(color: colors.textPrimary),
                ).expanded(),
              ],
            ),
            24.height.heightBox,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colors.borderSecondary),
                ),
                child: const ChatThreadHistory().paddingAll(16.width),
              ),
            ).expanded(),
          ],
        ).paddingSymmetric(horizontal: 20.width, vertical: 16.height),
      ),
    );
  }
}
