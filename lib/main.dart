import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rossete_v4/pages/start_page.dart';

void setup() {
  GetIt.I.registerSingleton(GlobalKey<NavigatorState>());
}

void main() {
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
