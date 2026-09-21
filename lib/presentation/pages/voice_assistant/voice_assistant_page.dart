import 'dart:math' as math;

import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/assistant_header.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/navigation/app_settings_launcher.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/theme/app_theme.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/repository/speech_to_text_repository.dart';
import '../../../domain/repository/voice_assistant_chat_repository.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import 'bloc/voice_assistant_cubit.dart';

class VoiceAssistantPage extends StatelessWidget {
  const VoiceAssistantPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => VoiceAssistantCubit(
      context.read<SpeechToTextRepository>(),
      context.read<VoiceAssistantChatRepository>(),
    ),
    child: Theme(data: AppTheme.light, child: const _VoiceAssistantView()),
  );
}

class _VoiceAssistantView extends StatefulWidget {
  const _VoiceAssistantView();

  @override
  State<_VoiceAssistantView> createState() => _VoiceAssistantViewState();
}

class _VoiceAssistantViewState extends State<_VoiceAssistantView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool _requestingPermission = false;
  bool _navigatingToChat = false;
  late final AnimationController _motion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<VoiceAssistantCubit>().prepare();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.paused ||
            state == AppLifecycleState.hidden) &&
        mounted &&
        !_requestingPermission) {
      context.read<VoiceAssistantCubit>().stopForBackground();
    }
  }

  Future<void> _allowMicrophone() async {
    if (_requestingPermission) return;
    _requestingPermission = true;
    try {
      await context.read<VoiceAssistantCubit>().requestPermission();
    } finally {
      _requestingPermission = false;
    }
  }

  void _onStateChanged(BuildContext context, VoiceAssistantState state) {
    final animated = !MediaQuery.disableAnimationsOf(context);
    final duration = state.status == VoiceAssistantStatus.processing
        ? const Duration(milliseconds: 4800)
        : const Duration(milliseconds: 2400);
    if (_motion.duration != duration) {
      _motion.stop();
      _motion.duration = duration;
    }
    if (animated &&
        (state.status == VoiceAssistantStatus.listening ||
            state.status == VoiceAssistantStatus.processing)) {
      if (!_motion.isAnimating) _motion.repeat();
    } else {
      _motion.stop();
    }
    if (state.sessionExpired) {
      const LoginRoute().go(context);
    } else if (state.status == VoiceAssistantStatus.success &&
        !_navigatingToChat) {
      _navigatingToChat = true;
      _motion.stop();
      ChatRoute(
        threadId: state.threadId,
        voiceResult: (message: state.committedTranscript, reply: state.answer),
      ).go(context);
    }
  }

  Future<void> _openKeyboardChat() async {
    final cubit = context.read<VoiceAssistantCubit>();
    await cubit.stopForBackground();
    if (!mounted) return;
    const ChatRoute().goWithDraft(
      context,
      cubit.state.displayTranscript.trim(),
    );
  }

  Future<void> _back() async {
    await context.read<VoiceAssistantCubit>().stopForBackground();
    if (mounted) context.go(HomeChatAiRoute.path);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _motion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return BlocListener<VoiceAssistantCubit, VoiceAssistantState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: colors.surfacePrimary,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -.24),
              radius: 1.2,
              colors: [
                Color.lerp(colors.surfacePrimary, colors.voiceCyan, .12)!,
                colors.surfacePrimary,
              ],
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
              buildWhen: (before, after) => before.status != after.status,
              builder: (context, state) => Column(
                children: [
                  AssistantHeader(
                    title: S.of(context).voiceAssistantTitle,
                    backLabel: S.of(context).backToHome,
                    onBack: _back,
                    backKey: const Key('voice-back'),
                  ),
                  if (state.permissionNeeded) ...[
                    _PermissionPrompt(onAllow: _allowMicrophone).expanded(),
                    _KeyboardSwitch(onPressed: _openKeyboardChat),
                    24.height.heightBox,
                  ] else ...[
                    24.height.heightBox,
                    const _VoiceStatus(),
                    BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
                      buildWhen: (before, after) =>
                          before.status != after.status ||
                          before.displayTranscript != after.displayTranscript,
                      builder: (context, voiceState) =>
                          voiceState.status == VoiceAssistantStatus.paused &&
                              voiceState.displayTranscript.isNotEmpty
                          ? IrhText.small(
                              S.of(context).voiceAssistantReviewBeforeSend,
                              color: colors.textSecondary,
                            )
                          : const SizedBox.shrink(),
                    ),
                    _VoiceWaveform(motion: _motion).expanded(),
                    const _VoiceConversation().expanded(),
                    _KeyboardSwitch(onPressed: _openKeyboardChat),
                    _VoiceControls(motion: _motion),
                  ],
                ],
              ).paddingSymmetric(horizontal: 20.width),
            ),
          ),
        ),
      ),
    );
  }
}

class _VoiceStatus extends StatelessWidget {
  const _VoiceStatus();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return SizedBox(
      height: 48.height,
      child: Center(
        child: BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
          buildWhen: (before, after) =>
              before.status != after.status || before.error != after.error,
          builder: (context, state) {
            final label = switch (state.status) {
              VoiceAssistantStatus.initializing =>
                strings.voiceAssistantInitializing,
              VoiceAssistantStatus.permissionRequired =>
                strings.voiceAssistantPermissionTitle,
              VoiceAssistantStatus.listening => strings.voiceAssistantListening,
              VoiceAssistantStatus.paused => strings.voiceAssistantPaused,
              VoiceAssistantStatus.processing =>
                strings.voiceAssistantProcessing,
              VoiceAssistantStatus.success => strings.voiceAssistantSent,
              VoiceAssistantStatus.error => switch (state.error) {
                VoiceAssistantError.unavailable => strings.speechUnavailable,
                VoiceAssistantError.noSpeech => strings.voiceAssistantNoSpeech,
                VoiceAssistantError.recognition => strings.speechStartFailed,
                VoiceAssistantError.network =>
                  strings.voiceAssistantNetworkError,
                VoiceAssistantError.chatbot => strings.voiceAssistantChatError,
                VoiceAssistantError.permission =>
                  strings.voiceAssistantPermissionDenied,
                null => strings.voiceAssistantTapToStart,
              },
            };
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              child: IrhText.smallMedium(
                label,
                key: ValueKey(label),
                textAlign: TextAlign.center,
                maxLines: 2,
                color: state.status == VoiceAssistantStatus.error
                    ? context.appColorScheme.textError
                    : context.appColorScheme.textPrimary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PermissionPrompt extends StatelessWidget {
  const _PermissionPrompt({required this.onAllow});

  final VoidCallback onAllow;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
          buildWhen: (before, after) =>
              before.permissionAttempted != after.permissionAttempted ||
              before.status != after.status,
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IrhText.title(
                strings.voiceAssistantPermissionTitle,
                textAlign: TextAlign.center,
              ),
              12.height.heightBox,
              IrhText.regular(
                strings.voiceAssistantPermissionDescription,
                color: colors.textSecondary,
                textAlign: TextAlign.center,
              ),
              if (state.permissionAttempted) ...[
                12.height.heightBox,
                IrhText.small(
                  strings.voiceAssistantPermissionDenied,
                  color: colors.textError,
                  textAlign: TextAlign.center,
                ),
              ],
              24.height.heightBox,
              IrhButton(
                key: const Key('voice-allow-microphone'),
                label: strings.voiceAssistantAllowMicrophone,
                onPressed: state.status == VoiceAssistantStatus.initializing
                    ? null
                    : onAllow,
              ),
              if (state.permissionAttempted) ...[
                12.height.heightBox,
                IrhTextButton(
                  label: strings.voiceAssistantOpenSettings,
                  onPressed: AppSettingsLauncher.open,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyboardSwitch extends StatelessWidget {
  const _KeyboardSwitch({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = S.of(context).voiceAssistantTypeInstead;
    final colors = context.appColorScheme;
    return Semantics(
      button: true,
      label: label,
      child: CupertinoButton(
        key: const Key('voice-keyboard-switch'),
        minimumSize: Size(44.width, 44.height),
        padding: EdgeInsets.symmetric(horizontal: 8.width),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.keyboard, size: 20.sp, color: colors.iconBrand),
            8.width.widthBox,
            IrhText.smallMedium(
              label,
              color: colors.textBrand,
              textAlign: TextAlign.center,
              maxLines: 2,
            ).flexible(),
          ],
        ),
      ),
    );
  }
}

class _VoiceWaveform extends StatelessWidget {
  const _VoiceWaveform({required this.motion});

  final Animation<double> motion;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
      buildWhen: (before, after) =>
          before.status != after.status ||
          before.inputLevel != after.inputLevel,
      builder: (context, state) => AnimatedBuilder(
        animation: motion,
        builder: (context, _) => CustomPaint(
          painter: _WavePainter(
            phase: motion.value,
            level: state.inputLevel,
            status: state.status,
            colors: [
              Color.lerp(colors.voiceViolet, colors.textPrimary, .2)!,
              Color.lerp(colors.voicePink, colors.textPrimary, .2)!,
              Color.lerp(colors.voiceBlue, colors.textPrimary, .2)!,
              Color.lerp(colors.voiceCyan, colors.textPrimary, .2)!,
            ],
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter({
    required this.phase,
    required this.level,
    required this.status,
    required this.colors,
  });

  final double phase;
  final double level;
  final VoiceAssistantStatus status;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final active = status == VoiceAssistantStatus.listening;
    final processing = status == VoiceAssistantStatus.processing;
    final moving = active || processing;
    final strength = active
        ? .3 + level * .8
        : processing
        ? .22
        : moving
        ? .38
        : .06;
    final width = size.width;
    for (var line = 0; line < 8; line++) {
      final path = Path();
      for (var step = 0; step <= 100; step++) {
        final x = width * step / 100;
        final position = step / 100;
        final envelope = math.pow(math.sin(math.pi * position), 2).toDouble();
        final wave = math.sin(
          position * math.pi * (4 + line % 3) +
              line * .72 -
              phase * math.pi * 2,
        );
        final cross = math.sin(
          position * math.pi * (7 + line % 2) - line * .55 + phase * math.pi,
        );
        final y =
            centerY +
            (wave + cross * .35) *
                envelope *
                size.height *
                .27 *
                strength *
                (line.isEven ? 1 : -1);
        if (step == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.68
        ..shader = LinearGradient(
          colors: [
            colors[line % 4],
            colors[(line + 1) % 4],
            colors[(line + 2) % 4],
          ],
        ).createShader(Offset.zero & size);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      phase != old.phase || level != old.level || status != old.status;
}

class _VoiceConversation extends StatelessWidget {
  const _VoiceConversation();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
        buildWhen: (before, after) =>
            before.committedTranscript != after.committedTranscript ||
            before.partialTranscript != after.partialTranscript ||
            before.answer != after.answer ||
            before.error != after.error ||
            before.errorDetail != after.errorDetail,
        builder: (context, state) {
          final strings = S.of(context);
          final colors = context.appColorScheme;
          final transcript = state.displayTranscript;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (transcript.isNotEmpty)
                    IrhText.title(
                      transcript,
                      textAlign: TextAlign.center,
                      color: colors.textPrimary,
                    )
                  else if (state.error == null)
                    IrhText.regular(
                      strings.voiceAssistantPlaceholder,
                      textAlign: TextAlign.center,
                      color: colors.textSecondary,
                    ),
                  if (state.answer.isNotEmpty) ...[
                    16.height.heightBox,
                    IrhText.regular(
                      state.answer,
                      textAlign: TextAlign.center,
                      color: colors.textSecondary,
                    ),
                  ],
                  if (state.error != null) ...[
                    16.height.heightBox,
                    IrhTextButton(
                      label: strings.voiceAssistantRetry,
                      onPressed: () =>
                          context.read<VoiceAssistantCubit>().startListening(),
                    ),
                    if (state.error == VoiceAssistantError.permission)
                      IrhTextButton(
                        label: strings.voiceAssistantOpenSettings,
                        onPressed: AppSettingsLauncher.open,
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      );
}

class _VoiceControls extends StatelessWidget {
  const _VoiceControls({required this.motion});

  final Animation<double> motion;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return SizedBox(
      height: 224.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
            buildWhen: (before, after) =>
                before.status != after.status ||
                before.inputLevel != after.inputLevel,
            builder: (context, state) => AnimatedBuilder(
              animation: motion,
              builder: (context, _) => Stack(
                alignment: Alignment.center,
                children: [
                  for (var ring = 0; ring < 4; ring++)
                    Container(
                      width: (120 + ring * 36).width,
                      height: (120 + ring * 36).height,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              Color.lerp(
                                colors.voiceCyan,
                                colors.textPrimary,
                                .2,
                              )!.withValues(
                                alpha:
                                    state.status ==
                                        VoiceAssistantStatus.listening
                                    ? .12 +
                                          .07 * (1 - ring / 4) +
                                          (.04 + state.inputLevel * .08) *
                                              (1 -
                                                  ((motion.value + ring / 4) %
                                                      1))
                                    : .12 + .07 * (1 - ring / 4),
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Centers sit 116 units from the wave center, overlapping its outer ring.
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
                  builder: (context, state) => _CircleControl(
                    key: const Key('voice-reset'),
                    label: strings.voiceAssistantReset,
                    icon: CupertinoIcons.refresh,
                    color: colors.voiceBlue,
                    foregroundColor: colors.surfaceSecondary,
                    onPressed:
                        state.status == VoiceAssistantStatus.processing ||
                            state.status == VoiceAssistantStatus.initializing ||
                            (state.displayTranscript.isEmpty &&
                                state.status != VoiceAssistantStatus.listening)
                        ? null
                        : () => context.read<VoiceAssistantCubit>().reset(),
                  ),
                ),
                BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
                  buildWhen: (before, after) => before.status != after.status,
                  builder: (context, state) => _CircleControl(
                    key: const Key('voice-microphone'),
                    label: state.status == VoiceAssistantStatus.listening
                        ? strings.voiceAssistantPause
                        : strings.voiceAssistantResume,
                    icon: state.status == VoiceAssistantStatus.listening
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.mic_fill,
                    size: 72,
                    color: state.status == VoiceAssistantStatus.listening
                        ? colors.textError
                        : colors.surfaceTemary,
                    foregroundColor:
                        state.status == VoiceAssistantStatus.listening
                        ? colors.surfaceSecondary
                        : colors.iconPrimary,
                    onPressed:
                        state.status == VoiceAssistantStatus.processing ||
                            state.status == VoiceAssistantStatus.initializing ||
                            state.status == VoiceAssistantStatus.success
                        ? null
                        : () => context
                              .read<VoiceAssistantCubit>()
                              .toggleListening(),
                  ),
                ),
                BlocBuilder<VoiceAssistantCubit, VoiceAssistantState>(
                  builder: (context, state) => _CircleControl(
                    key: const Key('voice-send'),
                    label: strings.voiceAssistantSend,
                    icon: CupertinoIcons.arrow_up,
                    color: colors.voiceCyan,
                    foregroundColor: colors.surfaceSecondary,
                    loading: state.status == VoiceAssistantStatus.processing,
                    onPressed: state.canSend
                        ? () => context.read<VoiceAssistantCubit>().send()
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleControl extends StatelessWidget {
  const _CircleControl({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
    this.foregroundColor,
    this.size = 48,
    this.loading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? foregroundColor;
  final int size;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Opacity(
        opacity: onPressed == null && !loading ? .58 : 1,
        child: CupertinoButton(
          minimumSize: Size(48.width, 48.height),
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? colors.surfaceSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: colors.borderPrimary),
            ),
            child: loading
                ? CupertinoActivityIndicator(
                    color: foregroundColor ?? colors.iconPrimary,
                  )
                : Icon(
                    icon,
                    color: foregroundColor ?? colors.iconPrimary,
                    size: 24.sp,
                  ),
          ),
        ),
      ),
    );
  }
}
