import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form_controller.dart';
import 'package:rossete_v4/pages/start_page.dart';

void setup() {
  GetIt.I.registerSingleton(GlobalKey<NavigatorState>());
}

void main() {
  setup();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final UMKCreateFormController formController = UMKCreateFormController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: .from(
        colorScheme: .fromSeed(
          seedColor: .fromARGB(255, 121, 150, 255),
          brightness: .dark,
          dynamicSchemeVariant: .expressive,
        ),
      ),
      navigatorKey: GetIt.I<GlobalKey<NavigatorState>>(),
      home: StartPage(),
    );
  }
}
