import 'package:flutter_test/flutter_test.dart';
import 'package:rossete_v4/modules/tasks/task.dart';

void main() {
  group("Тест базовой задачи -> ", () {
    late final PlaceholderTask task;
    test('Создание задачи', () {
      task = PlaceholderTask();
    });

    test('Запуск и выполнение задачи', () async {
      await task.execute();
    });

    test('Тест ошибки', () async {
      expect(() async => await task.executeWithErrors(), throwsA(isA<Error>()));
    });
  });
}
