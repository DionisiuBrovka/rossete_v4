import 'package:flutter/material.dart';
import 'package:rossete_v4/forms/umk_create_form/u_m_k_create_form_controller.dart';

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
          TextFormField(
            controller: descController,
            minLines: 15,
            maxLines: 35,
            decoration: InputDecoration(
              label: Text("Описание предмета"),
              alignLabelWithHint: true,
            ),
          ),
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

class _DirectoryField extends FormField<String> {
  _DirectoryField({
    Key? key,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         key: key,
         initialValue: initialValue,
         onSaved: onSaved,
         validator: validator,
         autovalidateMode: autovalidateMode,
         builder: (FormFieldState<String> state) {
           return Builder(
             builder: (context) {
               return Container(
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: Theme.of(context).colorScheme.outline,
                   ),
                   borderRadius: BorderRadius.circular(22),
                   color: Theme.of(context).colorScheme.surfaceContainerLow,
                   boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
                 ),
                 child: Padding(
                   padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
                   child: Row(
                     children: [
                       Text("Выберите папку для УМК"),
                       Spacer(),
                       FilledButton.icon(
                         onPressed: () {},
                         label: Text("выбрать"),
                         icon: Icon(Icons.folder),
                       ),
                     ],
                   ),
                 ),
               );
             },
           );
         },
       );
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
