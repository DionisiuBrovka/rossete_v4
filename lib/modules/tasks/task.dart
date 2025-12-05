import 'dart:developer';

import 'package:flutter/foundation.dart';

enum TaskStatus { pending, inProgress, completed, failed }

abstract class Task with ChangeNotifier {
  final String id;
  final String name;

  TaskStatus status;

  static String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Task({required this.name, this.status = TaskStatus.pending})
    : id = _generateId() {
    log("Создана новая задача: $name#$id", name: "TASK");
  }

  Future<void> execute() async {
    status = TaskStatus.inProgress;
    notifyListeners();

    try {
      await _taskFunction();
      status = TaskStatus.completed;
      notifyListeners();
    } catch (e) {
      status = TaskStatus.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> _taskFunction();
}

class PlaceholderTask extends Task {
  PlaceholderTask({super.name = "Тестовая задача", super.status = .pending});

  @override
  Future<void> _taskFunction() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> executeWithErrors() async {
    status = TaskStatus.inProgress;
    await Future.delayed(Duration(seconds: 1));
    status = TaskStatus.failed;
    throw Error();
  }
}
