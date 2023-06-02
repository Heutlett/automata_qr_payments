import 'package:flutter/material.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/models/account.dart';
import 'account_info_activities.dart';
import 'account_info_card_buttons.dart';
import 'account_info_expand.dart';
import 'account_info_header.dart';
import 'package:flutter_app/utils/utils.dart';

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
                editAcc: () {
                  editAcc(context);
                },
                deleteAcc: () {
                  deleteAcc(context, account.id);
                },
                buttons: addButtons,
                account: account,
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

  void editAcc(BuildContext context) async {
    var cantonesResponse = await getProvincias();

    if (context.mounted) {
      if (cantonesResponse.success) {
        var cantonesList = cantonesResponse.data;
        Navigator.of(context)
            .pushNamed("/edit_account", arguments: [cantonesList, account]);
      } else {
        showAlertDialog(context, 'Error', cantonesResponse.message, 'Aceptar');
      }
    }
  }

  void deleteAcc(BuildContext context, String accountId) async {
    var deleteResponse = await deleteAccount(accountId);
    if (context.mounted) {
      if (deleteResponse.success) {
        showAlertDialog(
            context, 'Cuenta eliminada', deleteResponse.message, 'Aceptar');
      } else {
        showAlertDialog(context, 'Error', deleteResponse.message, 'Aceptar');
      }
    }
  }
}
