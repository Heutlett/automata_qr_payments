import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text_button.dart';

class AccountInfoCardButtons extends StatelessWidget {
  const AccountInfoCardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextButton(
            text: 'Expandir',
            function: () {},
            icon: Icons.open_in_full,
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
}
