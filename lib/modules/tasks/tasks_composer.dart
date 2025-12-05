import 'package:flutter/foundation.dart';
import 'package:rossete_v4/modules/tasks/task.dart';

enum TasksComposerStatus { pending, inProgress, completed, failed }

class TasksComposer with ChangeNotifier {
  TasksComposerStatus status = .pending;

  final List<Task> tasks;

  TasksComposer({required this.tasks});

  Future<void> procces() async {
    status = .inProgress;
    notifyListeners();

    for (var task in tasks) {
      await task.execute();
    }

    if (tasks.every((element) => element.status == .completed ? true : false)) {
      status = .completed;
      notifyListeners();
      return;
    }

    if (tasks
        .where((element) => element.status == .failed ? true : false)
        .isNotEmpty) {
      status = .failed;
      notifyListeners();
      return;
    }

    throw Error();
  }
}
