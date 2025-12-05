import 'package:flutter/material.dart';

class UMKCreateFormController with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> submitForm() async {
    formKey.currentState!.validate();
  }
}



// @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Theme.of(context).colorScheme.outline),
//         borderRadius: BorderRadius.circular(22),
//         color: Theme.of(context).colorScheme.surfaceContainerLow,
//         boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
//         child: Row(
//           children: [
//             Text("Выберите папку для УМК"),
//             Spacer(),
//             FilledButton.icon(
//               onPressed: () {},
//               label: Text("выбрать"),
//               icon: Icon(Icons.folder),
//             ),
//           ],
//         ),
//       ),
//     );
//   }