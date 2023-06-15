import 'package:flutter/material.dart';
import '/models/account.dart';

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
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          buttons == 1 || buttons == 2
              ? IconButton(
                  onPressed: expandAction,
                  icon: Icon(expandIcon),
                  color: Colors.blue)
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: editAction,
                  icon: Icon(Icons.edit),
                  color: Colors.amber.shade800,
                )
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: shareAction,
                  icon: Icon(Icons.share),
                  color: Colors.green,
                )
              : const SizedBox(),
          buttons == 2
              ? IconButton(
                  onPressed: deleteAction,
                  icon: Icon(Icons.delete),
                  color: Colors.red,
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

  void shareAction() {
    widget.shareAcc();
  }
}
