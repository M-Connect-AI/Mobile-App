import 'package:chatbot_project/data/repository/pending_action_store.dart';
import 'package:chatbot_project/domain/model/pending_action.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryStorage extends FlutterSecureStorage {
  String? value;

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
  }) async {
    this.value = value;
  }

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
  }) async => value;

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
  }) async {
    value = null;
  }
}

void main() {
  test('save, peek, consume only once', () async {
    final store = PendingActionStore(storage: _MemoryStorage());
    await store.save(
      const PendingAction(
        type: PendingActionType.createLeave,
        parameters: {'startDate': '2026-09-21', 'reason': 'Việc gia đình'},
      ),
    );
    expect((await store.peek())?.type, PendingActionType.createLeave);
    expect((await store.peek())?.parameters['reason'], 'Việc gia đình');
    expect((await store.consume())?.type, PendingActionType.createLeave);
    expect(await store.consume(), isNull);
  });

  test(
    'assistant question survives pending storage and is consumed once',
    () async {
      final store = PendingActionStore(storage: _MemoryStorage());
      await store.save(
        const PendingAction(
          type: PendingActionType.askAssistant,
          parameters: {'message': 'Tôi còn bao nhiêu ngày phép?'},
        ),
      );
      expect(
        (await store.peek())?.parameters['message'],
        'Tôi còn bao nhiêu ngày phép?',
      );
      expect((await store.consume())?.type, PendingActionType.askAssistant);
      expect(await store.consume(), isNull);
    },
  );
}
