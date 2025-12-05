import 'package:flutter/material.dart';

class CreateUMKPage extends StatefulWidget {
  const CreateUMKPage({super.key});

  @override
  State<CreateUMKPage> createState() => _CreateUMKPageState();
}

class _CreateUMKPageState extends State<CreateUMKPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создание УМК"), elevation: 2),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.create_new_folder),
      ),
    );
  }
}
