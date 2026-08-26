import 'package:equatable/equatable.dart';

enum MessageSender { user, assistant, system }

enum MessageType { text, audio }

enum MessageStatus { sending, sent, processing, success, failed }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.type,
    required this.sender,
    required this.createdAt,
    required this.status,
    this.content,
    this.audioPath,
    this.duration,
  });

  final String id;
  final MessageType type;
  final MessageSender sender;
  final String? content;
  final String? audioPath;
  final Duration? duration;
  final DateTime createdAt;
  final MessageStatus status;

  ChatMessage copyWith({
    String? content,
    String? audioPath,
    Duration? duration,
    MessageStatus? status,
  }) {
    return ChatMessage(
      id: id,
      type: type,
      sender: sender,
      content: content ?? this.content,
      audioPath: audioPath ?? this.audioPath,
      duration: duration ?? this.duration,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    sender,
    content,
    audioPath,
    duration,
    createdAt,
    status,
  ];
}
