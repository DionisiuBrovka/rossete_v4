import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:rossete_v4/modules/tasks/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: task,
      builder: (context, child) => Row(
        children: [
          Text(task.name),
          Spacer(),
          switch (task.status) {
            .pending => Icon(Icons.more_horiz),
            .inProgress => CircularProgressIndicator(strokeAlign: -4),
            .completed => Icon(Icons.check),
            .failed => Icon(Icons.close),
          },
        ],
      ),
    );
  }
}

@Preview()
Widget previewInAction() {
  return TaskWidget(task: PlaceholderTask(status: .pending)..execute());
}

@Preview()
Widget previewPending() {
  return TaskWidget(task: PlaceholderTask(status: .pending));
}

@Preview()
Widget previewInProgress() {
  return TaskWidget(task: PlaceholderTask(status: .inProgress));
}

@Preview()
Widget previewCompleted() {
  return TaskWidget(task: PlaceholderTask(status: .completed));
}

@Preview()
Widget previewFailed() {
  return TaskWidget(task: PlaceholderTask(status: .failed));
}
