import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';

class AccountInfoCardButtons extends StatefulWidget {
  const AccountInfoCardButtons(
      {super.key,
      required this.expandInfo,
      required this.editAcc,
      required this.deleteAcc,
      required this.account,
      required this.shareAcc,
      this.buttons = 0});
  final VoidCallback expandInfo;
  final VoidCallback editAcc;
  final VoidCallback deleteAcc;
  final VoidCallback shareAcc;
  final int buttons;
  final Account account;

  @override
  State<AccountInfoCardButtons> createState() => _AccountInfoCardButtonsState();
}

class _AccountInfoCardButtonsState extends State<AccountInfoCardButtons> {
  String expandName = 'Expandir';
  IconData expandIcon = Icons.open_in_full;
  late int buttons;
  late Account acc;

  @override
  void initState() {
    super.initState();
    buttons = widget.buttons;
    acc = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: buttons == 2
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          buttons == 1 || buttons == 2
              ? IconButton(
                  onPressed: _expandAction,
                  icon: Icon(expandIcon),
                  color: Colors.blue)
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: _editAction,
                  icon: const Icon(Icons.edit),
                  color: Colors.amber.shade800,
                )
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: acc.esCompartida ? null : _shareAction,
                  icon: const Icon(Icons.share),
                  color: acc.esCompartida ? Colors.grey : Colors.green,
                )
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: _deleteAction,
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _expandAction() {
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

  void _editAction() {
    widget.editAcc();
  }

  void _deleteAction() {
    widget.deleteAcc();
  }

  void _shareAction() {
    widget.shareAcc();
  }
}
