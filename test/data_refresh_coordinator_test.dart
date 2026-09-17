import 'package:chatbot_project/domain/model/chat_result.dart';
import 'package:chatbot_project/domain/service/data_refresh_coordinator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('coalesces synchronous refresh notifications', () async {
    final coordinator = DataRefreshCoordinator();
    addTearDown(coordinator.close);

    final emitted = <Set<DataRefreshScope>>[];
    final subscription = coordinator.changes.listen(emitted.add);
    addTearDown(subscription.cancel);

    coordinator.notify(const {DataRefreshScope.home});
    coordinator.notify(const {DataRefreshScope.leaves});
    coordinator.notify(const {DataRefreshScope.outlook});
    await Future<void>.delayed(Duration.zero);

    expect(emitted, [
      {
        DataRefreshScope.home,
        DataRefreshScope.leaves,
        DataRefreshScope.outlook,
      },
    ]);
  });
}
