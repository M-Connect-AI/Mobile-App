import '../../domain/model/chat_rich_content.dart';

abstract final class ChatRichContentMapper {
  static ChatUiAction? mapAction(Map<String, dynamic>? json) {
    if (json == null) return null;
    final label = _string(json['label']);
    final keyValue = _string(json['key']);
    if (label == null || keyValue == null) return null;
    return ChatUiAction(
      key: switch (keyValue) {
        'NONE' => ChatUiActionKey.none,
        'LEAVE_RESULTS' => ChatUiActionKey.leaveResults,
        'TRIP_RESULTS' => ChatUiActionKey.tripResults,
        'OUTLOOK_CALENDAR' => ChatUiActionKey.outlookCalendar,
        'OUTLOOK_MAIL' => ChatUiActionKey.outlookMail,
        'JIRA_ISSUE' => ChatUiActionKey.jiraIssue,
        'OUTLOOK_CONNECT' => ChatUiActionKey.outlookConnect,
        _ => ChatUiActionKey.unknown,
      },
      label: label,
      url: _string(json['url']),
      path: _string(json['path']),
    );
  }

  static List<ChatSuggestion> mapSuggestions(
    List<Map<String, dynamic>> values,
  ) => values
      .take(3)
      .map((json) {
        final label = _string(json['label']);
        final text = _string(json['text']);
        return label == null || text == null
            ? null
            : ChatSuggestion(label: label, text: text);
      })
      .whereType<ChatSuggestion>()
      .toList(growable: false);

  static List<ChatHighlight> mapHighlights(
    List<Map<String, dynamic>> values,
    String content,
  ) {
    final highlights =
        values
            .map((json) {
              final start = json['start'];
              final end = json['end'];
              final kind = _highlightKind(json['kind']);
              if (start is! int ||
                  end is! int ||
                  kind == null ||
                  start < 0 ||
                  end <= start ||
                  end > content.length) {
                return null;
              }
              return ChatHighlight(
                start: start,
                end: end,
                kind: kind,
                tone: _tone(json['tone']),
              );
            })
            .whereType<ChatHighlight>()
            .toList()
          ..sort((left, right) => left.start.compareTo(right.start));
    final result = <ChatHighlight>[];
    var previousEnd = 0;
    for (final highlight in highlights) {
      if (highlight.start < previousEnd) continue;
      result.add(highlight);
      previousEnd = highlight.end;
    }
    return List.unmodifiable(result);
  }

  static List<ChatRichBlock> mapBlocks(List<Map<String, dynamic>> values) =>
      values.map(_mapBlock).whereType<ChatRichBlock>().toList(growable: false);

  static ChatRichBlock? _mapBlock(Map<String, dynamic> json) {
    final type = switch (_string(json['type'])) {
      'kpis' => ChatBlockType.kpis,
      'bars' => ChatBlockType.bars,
      'donut' => ChatBlockType.donut,
      'progress' => ChatBlockType.progress,
      'list' => ChatBlockType.list,
      'quote' => ChatBlockType.quote,
      _ => null,
    };
    if (type == null) return null;
    final title = _string(json['title']);
    final rawItems = json['items'];
    final itemMaps = rawItems is List
        ? rawItems
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList(growable: false)
        : const <Map<String, dynamic>>[];

    switch (type) {
      case ChatBlockType.kpis:
        final items = itemMaps
            .map(_mapMetricItem)
            .whereType<ChatBlockItem>()
            .toList();
        return items.isEmpty ? null : ChatRichBlock(type: type, items: items);
      case ChatBlockType.bars:
      case ChatBlockType.donut:
        final items = itemMaps
            .take(6)
            .map(_mapChartItem)
            .whereType<ChatBlockItem>()
            .toList();
        return title == null || items.isEmpty
            ? null
            : ChatRichBlock(type: type, title: title, items: items);
      case ChatBlockType.progress:
        final value = json['value'];
        final max = json['max'];
        return title == null || value is! num || max is! num || max <= 0
            ? null
            : ChatRichBlock(
                type: type,
                title: title,
                value: value,
                max: max,
                suffix: _string(json['suffix']),
              );
      case ChatBlockType.list:
        final items = itemMaps
            .take(8)
            .map(_mapListItem)
            .whereType<ChatBlockItem>()
            .toList();
        return items.isEmpty
            ? null
            : ChatRichBlock(type: type, title: title, items: items);
      case ChatBlockType.quote:
        final text = _string(json['text']);
        return title == null || text == null || text.length > 320
            ? null
            : ChatRichBlock(
                type: type,
                title: title,
                text: text,
                source: _string(json['source']),
              );
    }
  }

  static ChatBlockItem? _mapMetricItem(Map<String, dynamic> json) {
    final label = _string(json['label']);
    final value = json['value'];
    if (label == null || (value is! String && value is! num)) return null;
    return ChatBlockItem(label: label, value: value, tone: _tone(json['tone']));
  }

  static ChatBlockItem? _mapChartItem(Map<String, dynamic> json) {
    final label = _string(json['label']);
    final value = json['value'];
    if (label == null || value is! num) return null;
    return ChatBlockItem(
      label: label,
      value: value,
      color: _string(json['color']),
    );
  }

  static ChatBlockItem? _mapListItem(Map<String, dynamic> json) {
    final title = _string(json['title']);
    if (title == null) return null;
    return ChatBlockItem(
      title: title,
      subtitle: _string(json['subtitle']),
      kicker: _string(json['kicker']),
      badge: _string(json['badge']),
      tone: _tone(json['tone']),
      url: _string(json['url']),
    );
  }

  static ChatHighlightKind? _highlightKind(Object? value) => switch (value) {
    'date' => ChatHighlightKind.date,
    'metric' => ChatHighlightKind.metric,
    'status' => ChatHighlightKind.status,
    'id' => ChatHighlightKind.id,
    'warn' => ChatHighlightKind.warn,
    _ => null,
  };

  static ChatTone? _tone(Object? value) => switch (value) {
    'ok' => ChatTone.ok,
    'warn' => ChatTone.warn,
    'bad' => ChatTone.bad,
    'neutral' => ChatTone.neutral,
    _ => null,
  };

  static String? _string(Object? value) {
    if (value is! String || value.trim().isEmpty) return null;
    return value.trim();
  }
}
