import 'package:flutter/material.dart';

import '../../../models/account.dart';
import 'account_info_activities.dart';
import 'account_info_header.dart';

class AccountInfoCard extends StatelessWidget {
  final Account account;

  const AccountInfoCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountInfoCardHeader(
          cedulaTipo: account.cedulaTipo,
          cedulaNumero: account.cedulaNumero,
          nombre: account.nombre,
        ),
        AccountInfoCardActivities(activities: account.actividades),
      ],
    );
  }
}
