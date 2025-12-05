import 'dart:developer';

import 'package:flutter/material.dart';

class UMKCreateFormData {
  final String apiKey;
  final String directory;
  final String name;
  final String shortName;
  final String description;

  UMKCreateFormData({
    required this.apiKey,
    required this.directory,
    required this.name,
    required this.shortName,
    required this.description,
  });
}

class UMKCreateFormController with ChangeNotifier {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController dirController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shortNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UMKCreateFormController() {
    log("создаем контролер ...", name: "UMK_CREATE_FORM_CONTROLLER");
  }

  Future<void> submitForm({
    Future<void> Function(UMKCreateFormData data)? onSuccses,
  }) async {
    if (formKey.currentState!.validate()) {
      log("форма валидна", name: "UMK_CREATE_FORM_CONTROLLER");
      if (onSuccses != null) {
        await onSuccses(
          UMKCreateFormData(
            apiKey: keyController.text,
            directory: dirController.text,
            name: nameController.text,
            shortName: shortNameController.text,
            description: descController.text,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    log("удаляем контролер ...", name: "UMK_CREATE_FORM_CONTROLLER");
    keyController.dispose();
    dirController.dispose();
    nameController.dispose();
    shortNameController.dispose();
    descController.dispose();
    super.dispose();
  }
}
