import 'package:flutter/material.dart';

import '../../../models/account.dart';
import 'account_info_activities.dart';
import 'account_info_card_buttons.dart';
import 'account_info_expand.dart';
import 'account_info_header.dart';

class AccountInfoCard extends StatefulWidget {
  final Account account;
  final int addButtons;

  const AccountInfoCard(
      {super.key, required this.account, this.addButtons = 0});

  @override
  State<AccountInfoCard> createState() => _AccountInfoCardState();
}

class _AccountInfoCardState extends State<AccountInfoCard> {
  bool isExpand = false;

  late Account account;
  late int addButtons;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    addButtons = widget.addButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountInfoCardHeader(
          cedulaTipo: widget.account.cedulaTipo,
          cedulaNumero: widget.account.cedulaNumero,
          nombre: widget.account.nombre,
        ),
        isExpand == true
            ? AccountInfoCardExpand(account: account)
            : const SizedBox(),
        AccountInfoCardActivities(activities: widget.account.actividades),
        addButtons != 0
            ? AccountInfoCardButtons(
                expandInfo: expandInfo,
                buttons: addButtons,
              )
            : const SizedBox(),
      ],
    );
  }

  void expandInfo() {
    setState(() {
      if (isExpand) {
        isExpand = false;
      } else {
        isExpand = true;
      }
    });
  }
}
