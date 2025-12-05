import 'package:flutter/foundation.dart';
import 'package:rossete_v4/modules/tasks/task.dart';

enum TasksComposerStatus { pending, inProgress, completed, failed }

class TasksComposer with ChangeNotifier {
  TasksComposerStatus status = .pending;

  final List<Task> tasks;

  final Future<void> Function()? onComplete;
  final Future<void> Function()? onFail;

  TasksComposer({required this.tasks, this.onComplete, this.onFail});

  Future<void> procces() async {
    status = .inProgress;
    notifyListeners();

    for (var task in tasks) {
      await task.execute();
    }

    if (tasks.every((element) => element.status == .completed ? true : false)) {
      status = .completed;
      notifyListeners();

      if (onComplete != null) {
        await onComplete!();
      }

      return;
    }

    if (tasks
        .where((element) => element.status == .failed ? true : false)
        .isNotEmpty) {
      status = .failed;
      notifyListeners();

      if (onFail != null) {
        await onFail!();
      }

      return;
    }

    throw Error();
  }
}
