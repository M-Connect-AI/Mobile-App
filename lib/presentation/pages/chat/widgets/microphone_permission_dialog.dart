import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/components/irh_button.dart';
import '../../../../common/components/irh_text.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../domain/repository/speech_to_text_repository.dart';
import '../../../../generated/l10n.dart';

Future<bool> confirmMicrophoneAccess(BuildContext context) async {
  if (await context.read<SpeechToTextRepository>().hasPermission()) {
    return true;
  }
  if (!context.mounted) return false;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => const _MicrophonePermissionDialog(),
  );
  return confirmed ?? false;
}

class _MicrophonePermissionDialog extends StatelessWidget {
  const _MicrophonePermissionDialog();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return AlertDialog(
      key: const Key('microphone-permission-dialog'),
      backgroundColor: colors.surfaceSecondary,
      title: IrhText.title(strings.microphonePermissionTitle),
      content: IrhText.regular(
        strings.microphonePermissionDescription,
        color: colors.textSecondary,
      ),
      actions: [
        IrhTextButton(
          label: strings.cancelButton,
          onPressed: () => context.pop(false),
        ),
        IrhTextButton(
          label: strings.microphonePermissionContinue,
          onPressed: () => context.pop(true),
        ),
      ],
    );
  }
}
