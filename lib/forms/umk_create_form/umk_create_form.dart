import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rossete_v4/forms/umk_create_form/umk_create_form_controller.dart';

class UMKCreateForm extends StatefulWidget {
  const UMKCreateForm({super.key, required this.formController});

  final UMKCreateFormController formController;

  @override
  State<UMKCreateForm> createState() => _UMKCreateFormState();
}

class _UMKCreateFormState extends State<UMKCreateForm> {
  late final TextEditingController keyController;
  late final TextEditingController dirController;
  late final TextEditingController nameController;
  late final TextEditingController shortNameController;
  late final TextEditingController descController;

  @override
  void initState() {
    keyController = TextEditingController();
    dirController = TextEditingController();
    nameController = TextEditingController();
    shortNameController = TextEditingController();
    descController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formController.formKey,
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        spacing: 16,
        children: [
          _DirectoryField(),
          _KeyField(keyController: keyController),
          _NameField(nameController: nameController),
          _ShortNameField(shortNameController: shortNameController),
          _DescField(descController: descController),
        ],
      ),
    );
  }

  @override
  void dispose() {
    keyController.dispose();
    dirController.dispose();
    nameController.dispose();
    shortNameController.dispose();
    descController.dispose();
    super.dispose();
  }
}

class _DescField extends StatelessWidget {
  const _DescField({required this.descController});

  final TextEditingController descController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descController,
      minLines: 15,
      maxLines: 35,
      decoration: InputDecoration(
        label: Text("Описание предмета"),
        alignLabelWithHint: true,
      ),
    );
  }
}

class _DirectoryField extends FormField<String> {
  _DirectoryField({
    super.key,
    String? initialValue,
    this.label = 'Выберите папку для УМК',
    this.buttonLabel = 'Выбрать',
    this.icon = Icons.folder,
    super.onSaved,
    super.validator,
    this.onChanged,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: initialValue ?? '',
         builder: (FormFieldState<String> state) {
           Future<void> pickDirectory(BuildContext context) async {
             try {
               final String? selected = await FilePicker.platform
                   .getDirectoryPath();

               if (selected != null) {
                 state.didChange(selected);
               } else {
                 state.didChange(null);
               }

               if (onChanged != null) {
                 onChanged(selected);
               }
             } catch (e) {
               // ignore: use_build_context_synchronously
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('Ошибка при выборе папки: $e')),
               );
             }
           }

           final theme = Theme.of(state.context);
           final value = state.value ?? '';

           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: theme.colorScheme.outline),
                   borderRadius: BorderRadius.circular(22),
                   color: theme.colorScheme.surfaceContainerLow,
                   boxShadow: const [
                     BoxShadow(blurRadius: 4, color: Colors.black12),
                   ],
                 ),
                 child: Padding(
                   padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                   child: Row(
                     children: [
                       Expanded(
                         child: Text(
                           value.isNotEmpty ? value : label,
                           style: value.isNotEmpty
                               ? theme.textTheme.bodyMedium
                               : theme.textTheme.bodyMedium?.copyWith(
                                   color: theme.textTheme.bodyMedium!.color
                                       ?.withAlpha(100),
                                 ),
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                       const SizedBox(width: 8),
                       FilledButton.icon(
                         onPressed: () => pickDirectory(state.context),
                         icon: Icon(icon),
                         label: Text(buttonLabel),
                       ),
                     ],
                   ),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 6, left: 8),
                   child: Text(
                     state.errorText ?? '',
                     style: theme.textTheme.bodySmall?.copyWith(
                       color: theme.colorScheme.error,
                     ),
                   ),
                 ),
             ],
           );
         },
       );

  final String label;
  final String buttonLabel;
  final IconData icon;
  final ValueChanged<String?>? onChanged;
}

class _ShortNameField extends StatelessWidget {
  const _ShortNameField({required this.shortNameController});

  final TextEditingController shortNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: shortNameController,
      enabled: true,
      decoration: InputDecoration(
        label: Text("Краткое название"),
        suffixIcon: Icon(Icons.label_important_rounded),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      enabled: true,
      decoration: InputDecoration(
        label: Text("Название"),
        suffixIcon: Icon(Icons.text_fields),
      ),
    );
  }
}

class _KeyField extends StatelessWidget {
  const _KeyField({required this.keyController});

  final TextEditingController keyController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: keyController,
      enabled: true,
      obscureText: true,
      decoration: InputDecoration(
        label: Text("API ключ"),
        suffixIcon: Icon(Icons.key),
      ),
    );
  }
}
