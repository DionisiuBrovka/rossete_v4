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
      builder: (context, child) => SizedBox(
        height: 24,
        child: Row(
          children: [
            Text(
              task.name,
              style: TextStyle(
                fontFamily: "Cascadia Code",
                height: 0.75,
                color: switch (task.status) {
                  .pending => Colors.grey,
                  .inProgress => Colors.white,
                  .failed => Colors.redAccent,
                  .completed => Colors.greenAccent,
                },
              ),
            ),
            Spacer(),
            switch (task.status) {
              .pending => Center(),
              .inProgress => CircularProgressIndicator(
                color: Colors.white,
                strokeAlign: -1,
                padding: .only(right: 4),
                constraints: .tight(Size(18, 18)),
              ),
              .completed => Icon(Icons.check, color: Colors.greenAccent),
              .failed => Icon(Icons.close, color: Colors.redAccent),
            },
          ],
        ),
      ),
    );
  }
}

@Preview()
Widget previewInAction() {
  return Card.outlined(
    child: TaskWidget(task: PlaceholderTask(status: .pending)..execute()),
  );
}

@Preview()
Widget previewPending() {
  return Card.outlined(
    child: TaskWidget(task: PlaceholderTask(status: .pending)),
  );
}

@Preview()
Widget previewInProgress() {
  return Card.outlined(
    child: TaskWidget(task: PlaceholderTask(status: .inProgress)),
  );
}

@Preview()
Widget previewCompleted() {
  return Card.outlined(
    child: TaskWidget(task: PlaceholderTask(status: .completed)),
  );
}

@Preview()
Widget previewFailed() {
  return Card.outlined(
    child: TaskWidget(task: PlaceholderTask(status: .failed)),
  );
}
