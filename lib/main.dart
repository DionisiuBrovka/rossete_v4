import 'package:flutter/material.dart';
import 'package:rossete_v4/forms/umk_create_form/u_m_k_create_form.dart';
import 'package:rossete_v4/forms/umk_create_form/u_m_k_create_form_controller.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final UMKCreateFormController formController = UMKCreateFormController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 450,
            child: UMKCreateForm(formController: formController),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            formController.submitForm();
          },
        ),
      ),
    );
  }
}
