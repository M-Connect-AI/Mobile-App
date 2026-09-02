import 'dart:async';
import 'package:flutter/material.dart';
import '../bloc/chat_state.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key, required this.stage});
  final AiProcessingState stage;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  int _activeDot = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 360), (_) {
      if (mounted) setState(() => _activeDot = (_activeDot + 1) % 3);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = switch (widget.stage) {
      AiProcessingState.thinking => 'Thinking...',
      AiProcessingState.understanding => 'Understanding request...',
      AiProcessingState.generatingResponse => 'Preparing response...',
      AiProcessingState.idle => 'Thinking...',
    };
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      label: label,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 18,
              color: colors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < 3; index++) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: index == _activeDot
                          ? colors.primary
                          : colors.onSurfaceVariant.withValues(alpha: .3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (index < 2) const SizedBox(width: 4),
                ],
                const SizedBox(width: 9),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onSurfaceVariant,
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
