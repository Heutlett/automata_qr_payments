import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';

import '../../../models/account.dart';
import '../general/my_text_button.dart';
import 'account_info_activities.dart';
import 'account_info_card_buttons.dart';
import 'account_info_expand.dart';
import 'account_info_header.dart';

class AccountInfoCard extends StatefulWidget {
  final Account account;
  final bool addButtons;

  const AccountInfoCard(
      {super.key, required this.account, this.addButtons = false});

  @override
  State<AccountInfoCard> createState() => _AccountInfoCardState();
}

class _AccountInfoCardState extends State<AccountInfoCard> {
  bool isExpand = false;

  late Account account;
  late bool addButtons;

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
        isExpand == true ? AccountInfoCardExpand(account: account) : SizedBox(),
        AccountInfoCardActivities(activities: widget.account.actividades),
        addButtons == true
            ? AccountInfoCardButtons(expandInfo: expandInfo)
            : SizedBox(),
      ],
    );
  }

  void expandInfo() {
    print('Prueba');
    setState(() {
      if (isExpand) {
        isExpand = false;
      } else {
        isExpand = true;
      }
    });
  }
}