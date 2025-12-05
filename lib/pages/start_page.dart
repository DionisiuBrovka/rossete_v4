import 'package:flutter/material.dart';
import 'package:rossete_v4/pages/create_umk_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _StartPageMenu(
          title: 'Rossete',
          version: 'v3',
          onCreatePress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateUMKPage()),
            );
          },
          onLoadPress: null,
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showAdaptiveDialog(
            context: context,
            builder: (context) => Dialog(
              child: SizedBox(
                width: 450,
                child: Padding(
                  padding: .symmetric(vertical: 8, horizontal: 24),
                  child: Text("TODO сделать описание"),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.info),
      ),
    );
  }
}

class _StartPageMenu extends StatelessWidget {
  const _StartPageMenu({
    required this.title,
    required this.version,
    this.onCreatePress,
    this.onLoadPress,
  });

  final String title;
  final String version;
  final Function()? onCreatePress;
  final Function()? onLoadPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        _TitleText(title: title, version: version),
        TextButton.icon(
          onPressed: onCreatePress,
          icon: Icon(Icons.create),
          label: Text("Создать УМК"),
        ),
        TextButton.icon(
          onPressed: onLoadPress,
          icon: Icon(Icons.upload),
          label: Text("Загрузить УМК"),
        ),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({required this.title, required this.version});

  final String title;
  final String version;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 4,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Text(
          version,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: .italic,
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withAlpha(100),
          ),
        ),
      ],
    );
  }
}
