import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form_controller.dart';
import 'package:rossete_v4/modules/tasks/task.dart';
import 'package:rossete_v4/modules/tasks/tasks_composer.dart';
import 'package:rossete_v4/modules/tasks/widgets/task_composer_widget.dart';
import 'package:rossete_v4/pages/main_page.dart';

enum CreateUMKPageStatus { formEditing, process }

class CreateUMKPage extends StatefulWidget {
  const CreateUMKPage({super.key});

  @override
  State<CreateUMKPage> createState() => _CreateUMKPageState();
}

class _CreateUMKPageState extends State<CreateUMKPage> {
  CreateUMKPageStatus status = CreateUMKPageStatus.formEditing;

  late final UMKCreateFormController formController;

  final TasksComposer composer = TasksComposer(
    tasks: [
      PlaceholderTask(),
      PlaceholderTask(),
      PlaceholderTask(),
      PlaceholderTask(),
    ],
    onComplete: () => Navigator.pushReplacement(
      GetIt.I<GlobalKey<NavigatorState>>().currentState!.context,
      MaterialPageRoute(builder: (context) => MainPage()),
    ),
  );

  Future<void> onFormSubmitSuccess(UMKCreateFormData data) async {
    log("Начинается обработка формы", name: "CREATE_UMK_PAGE");

    setState(() {
      status = CreateUMKPageStatus.process;
      composer.procces();
    });
  }

  @override
  void initState() {
    formController = UMKCreateFormController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = status == CreateUMKPageStatus.process;

    return PopScope(
      canPop: !isProcessing,
      child: Scaffold(
        appBar: AppBar(title: const Text("Создание УМК"), elevation: 2),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: status == CreateUMKPageStatus.formEditing
            ? FloatingActionButton(
                onPressed: () =>
                    formController.submitForm(onSuccess: onFormSubmitSuccess),
                child: const Icon(Icons.create_new_folder),
              )
            : null,

        body: switch (status) {
          CreateUMKPageStatus.formEditing => _FormState(
            formController: formController,
          ),

          CreateUMKPageStatus.process => _ProcessState(composer: composer),
        },
      ),
    );
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }
}

class _ProcessState extends StatelessWidget {
  const _ProcessState({super.key, required this.composer});

  final TasksComposer composer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Text(
                "Создаем УМК",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                width: 475,
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withAlpha(255 ~/ 2),
                  ),
                ),
                child: TaskComposerWidget(composer: composer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormState extends StatelessWidget {
  const _FormState({super.key, required this.formController});

  final UMKCreateFormController formController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SizedBox(
          width: 575,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: UMKCreateForm(formController: formController),
          ),
        ),
      ),
    );
  }
}
