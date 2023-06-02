import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text_button.dart';
import '/models/account.dart';

class AccountInfoCardButtons extends StatefulWidget {
  const AccountInfoCardButtons(
      {super.key,
      required this.expandInfo,
      required this.editAcc,
      required this.deleteAcc,
      required this.account,
      this.buttons = 0});
  final VoidCallback expandInfo;
  final VoidCallback editAcc;
  final VoidCallback deleteAcc;
  final int buttons;
  final Account account;

  @override
  State<AccountInfoCardButtons> createState() => _AccountInfoCardButtonsState();
}

class _AccountInfoCardButtonsState extends State<AccountInfoCardButtons> {
  String expandName = 'Expandir';
  IconData expandIcon = Icons.open_in_full;
  late int buttons;

  @override
  void initState() {
    super.initState();
    buttons = widget.buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: buttons == 2
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          buttons == 1 || buttons == 2
              ? MyTextButton(
                  text: expandName,
                  function: expandAction,
                  icon: expandIcon,
                )
              : const SizedBox(),
          buttons == 2
              ? MyTextButton(
                  text: 'Editar',
                  function: editAction,
                  icon: Icons.edit,
                  foregroundColor: Colors.amber.shade800,
                )
              : const SizedBox(),
          buttons == 2
              ? MyTextButton(
                  text: 'Eliminar',
                  function: deleteAction,
                  icon: Icons.delete,
                  foregroundColor: Colors.red,
                )
              : const SizedBox(),
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

  void editAction() {
    widget.editAcc();
  }

  void deleteAction() {
    widget.deleteAcc();
  }
}
