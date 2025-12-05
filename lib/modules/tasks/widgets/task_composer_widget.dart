import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:rossete_v4/modules/tasks/task.dart';
import 'package:rossete_v4/modules/tasks/tasks_composer.dart';
import 'package:rossete_v4/modules/tasks/widgets/task_widget.dart';

class TaskComposerWidget extends StatelessWidget {
  const TaskComposerWidget({super.key, required this.composer});

  final TasksComposer composer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListenableBuilder(
        listenable: composer,
        builder: (context, child) => Column(
          mainAxisSize: .min,
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: composer.tasks
              .map((task) => TaskWidget(task: task))
              .toList(),
        ),
      ),
    );
  }
}

@Preview()
Widget preview() {
  return Card.outlined(
    child: TaskComposerWidget(
      composer: TasksComposer(
        tasks: [
          PlaceholderTask(name: "In Englishe"),
          PlaceholderTask(),
          PlaceholderTask(),
          PlaceholderTask(),
        ],
      )..procces(),
    ),
  );
}
