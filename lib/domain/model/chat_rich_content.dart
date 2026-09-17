import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_rich_content.freezed.dart';

enum ChatUiActionKey {
  none,
  leaveResults,
  tripResults,
  outlookCalendar,
  outlookMail,
  jiraIssue,
  outlookConnect,
  unknown,
}

enum ChatBlockType { kpis, bars, donut, progress, list, quote }

enum ChatTone { ok, warn, bad, neutral }

enum ChatHighlightKind { date, metric, status, id, warn }

@freezed
abstract class ChatUiAction with _$ChatUiAction {
  const factory ChatUiAction({
    required ChatUiActionKey key,
    required String label,
    String? url,
    String? path,
  }) = _ChatUiAction;
}

@freezed
abstract class ChatSuggestion with _$ChatSuggestion {
  const factory ChatSuggestion({required String label, required String text}) =
      _ChatSuggestion;
}

@freezed
abstract class ChatHighlight with _$ChatHighlight {
  const factory ChatHighlight({
    required int start,
    required int end,
    required ChatHighlightKind kind,
    ChatTone? tone,
  }) = _ChatHighlight;
}

@freezed
abstract class ChatBlockItem with _$ChatBlockItem {
  const factory ChatBlockItem({
    String? label,
    Object? value,
    String? title,
    String? subtitle,
    String? kicker,
    String? badge,
    ChatTone? tone,
    String? color,
    String? url,
  }) = _ChatBlockItem;
}

@freezed
abstract class ChatRichBlock with _$ChatRichBlock {
  const factory ChatRichBlock({
    required ChatBlockType type,
    String? title,
    String? text,
    String? source,
    num? value,
    num? max,
    String? suffix,
    @Default(<ChatBlockItem>[]) List<ChatBlockItem> items,
  }) = _ChatRichBlock;
}
