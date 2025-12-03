enum TaskStatus { pending, inProgress, completed, failed }

abstract class Task {
  final String id;
  final String name;
  TaskStatus status;

  static String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Task({required this.name, this.status = TaskStatus.pending})
    : id = _generateId();

  Future<void> execute() async {
    status = TaskStatus.inProgress;
    try {
      final subTasks = await _taskFunction();

      if (subTasks != null) {
        subTasks.subTasks.forEach((subTask) async {
          await subTask.execute();
          if (subTask.status == TaskStatus.failed) {
            throw Exception('Subtask ${subTask.name} failed');
          }
        });
      }

      status = TaskStatus.completed;
    } catch (e) {
      status = TaskStatus.failed;
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
