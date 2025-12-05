import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form_controller.dart';

enum CreateUMKPageStatus { formEditing, procces }

class CreateUMKPage extends StatefulWidget {
  const CreateUMKPage({super.key});

  @override
  State<CreateUMKPage> createState() => _CreateUMKPageState();
}

class _CreateUMKPageState extends State<CreateUMKPage> {
  CreateUMKPageStatus status = .formEditing;

  late final UMKCreateFormController formController;

  Future<void> onFormSubmitSucces(UMKCreateFormData data) async {
    setState(() {
      log("начинается обработка формы", name: "CREATE_UMK_PAGE");
      status = .procces;
    });
  }

  @override
  void initState() {
    formController = UMKCreateFormController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создание УМК"), elevation: 2),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: status == .formEditing
          ? FloatingActionButton(
              onPressed: () =>
                  formController.submitForm(onSuccses: onFormSubmitSucces),
              child: Icon(Icons.create_new_folder),
            )
          : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: .topCenter,
          child: SizedBox(
            width: 575,
            child: Padding(
              padding: .only(bottom: 90),
              child: UMKCreateForm(formController: formController),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }
}
