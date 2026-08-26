import 'package:flutter/material.dart';

class VoiceRecorder extends StatefulWidget {
  const VoiceRecorder({
    super.key,
    required this.duration,
    required this.onCancel,
    required this.onSend,
  });
  final Duration duration;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final minutes = widget.duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (widget.duration.inSeconds % 60).toString().padLeft(2, '0');
    return Container(
      key: const Key('voice-recorder'),
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: .42),
        border: Border.all(color: colors.error.withValues(alpha: .15)),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: colors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$minutes:$seconds',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(18, (index) {
                  final wave = ((index % 5) + 1) / 5;
                  final height = 5 + 22 * ((_animation.value + wave) % 1);
                  return Container(
                    width: 2.5,
                    height: height,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: colors.error.withValues(alpha: .65),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ),
          TextButton(onPressed: widget.onCancel, child: const Text('Hủy')),
          IconButton.filled(
            key: const Key('stop-send-voice'),
            tooltip: 'Dừng và gửi',
            onPressed: widget.onSend,
            style: IconButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: colors.onError,
            ),
            icon: const Icon(Icons.stop_rounded),
          ),
        ],
      ),
    );
  }
}
