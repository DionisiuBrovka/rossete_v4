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
      final subTasks = await _taskFunction();
      if (subTasks != null) {
        subTasks.execute();
      }
      status = TaskStatus.completed;
      notifyListeners();
    } catch (e) {
      status = TaskStatus.failed;
      notifyListeners();
      rethrow;
    }
  }

  Future<CompositeTask?> _taskFunction();
}

class CompositeTask extends Task {
  final List<Task> subTasks;

  CompositeTask({required super.name, this.subTasks = const []});

  @override
  Future<CompositeTask?> _taskFunction() async {
    for (var task in subTasks) {
      await task.execute();

      if (task.status == TaskStatus.failed) {
        throw Exception('Subtask ${task.name} failed');
      }
    }
    return null;
  }
}

class PlaceholderTask extends Task {
  PlaceholderTask({super.name = "Тестовая задача", super.status = .pending});

  @override
  Future<CompositeTask?> _taskFunction() async {
    await Future.delayed(Duration(seconds: 1));
    return null;
  }

  Future<void> executeWithErrors() async {
    status = TaskStatus.inProgress;
    await Future.delayed(Duration(seconds: 1));
    status = TaskStatus.failed;
    throw Error();
  }
}
