import 'package:flutter/material.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

import '../../../../generated/l10n.dart';

class VoiceRecorder extends StatefulWidget {
  const VoiceRecorder({
    super.key,
    required this.duration,
    required this.transcript,
    required this.onCancel,
    required this.onSend,
  });
  final Duration duration;
  final String transcript;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  late final Stream<Amplitude> _amplitudeStream;

  @override
  void initState() {
    super.initState();
    _amplitudeStream = createRandomAmplitudeStream();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final minutes = widget.duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (widget.duration.inSeconds % 60).toString().padLeft(2, '0');
    return Container(
      key: const Key('voice-recorder'),
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 10),
      decoration: BoxDecoration(
        color: colors.errorContainer.withValues(alpha: .42),
        border: Border.all(color: colors.error.withValues(alpha: .15)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            child: Text(
              widget.transcript.isEmpty ? S.of(context).voiceListening : widget.transcript,
              key: ValueKey(widget.transcript),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 54,
            child: ClipRect(
              child: AnimatedWaveList(
                stream: _amplitudeStream,
                barBuilder: (animation, amplitude) => SizedBox(
                  width: 10,
                  height: 54,
                  child: Center(
                    child: ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: Container(
                        width: 5,
                        height: 6 + (amplitude.current / amplitude.max) * 46,
                        decoration: BoxDecoration(
                          color: colors.error.withValues(alpha: .65),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
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
                style: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: widget.onCancel,
                style: TextButton.styleFrom(
                  foregroundColor: colors.onSurfaceVariant,
                ),
                child: Text(S.of(context).cancelButton),
              ),
              IconButton.filled(
                key: const Key('stop-send-voice'),
                tooltip: S.of(context).voiceStopAndSend,
                onPressed: widget.onSend,
                style: IconButton.styleFrom(
                  backgroundColor: colors.error,
                  foregroundColor: colors.onError,
                ),
                icon: const Icon(Icons.stop_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
