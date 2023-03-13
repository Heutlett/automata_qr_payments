import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text_button.dart';

class AccountInfoCardButtons extends StatefulWidget {
  const AccountInfoCardButtons({super.key, required this.expandInfo});
  final VoidCallback expandInfo;

  @override
  State<AccountInfoCardButtons> createState() => _AccountInfoCardButtonsState();
}

class _AccountInfoCardButtonsState extends State<AccountInfoCardButtons> {
  String expandName = 'Expandir';
  IconData expandIcon = Icons.open_in_full;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextButton(
            text: expandName,
            function: expandAction,
            icon: expandIcon,
          ),
          MyTextButton(
            text: 'Editar',
            function: () {},
            icon: Icons.edit,
            foregroundColor: Colors.amber.shade800,
          ),
          MyTextButton(
            text: 'Eliminar',
            function: () {},
            icon: Icons.delete,
            foregroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void expandAction() {
    setState(() {
      if (expandName == 'Expandir') {
        expandName = 'Contraer';
        expandIcon = Icons.close_fullscreen;
      } else {
        expandName = 'Expandir';
        expandIcon = Icons.open_in_full;
      }
    });
    widget.expandInfo();
  }
}
