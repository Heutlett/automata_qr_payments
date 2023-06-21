import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

import 'package:flutter_app/screens/widgets/account/account_info_card.dart';

class SelectAccountQrPage extends StatelessWidget {
  const SelectAccountQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione su cuenta receptor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: accounts.map((acc) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      color: acc.cedulaTipo == 'Juridica'
                          ? const Color.fromARGB(255, 180, 193, 255)
                          : const Color.fromARGB(255, 180, 234, 255),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AccountInfoCard(account: acc, addButtons: 1),
                          ),
                          MyButton(
                            text: 'Seleccionar',
                            function: () => _showGenerateQr(context, acc),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showGenerateQr(BuildContext context, Account account) async {
    var codigoQR = await getAccountBillingQr(int.parse(account.id));
    var args = [
      account.cedulaTipo,
      account.cedulaNumero,
      account.nombre,
      codigoQR
    ];

    if (context.mounted) {
      Navigator.of(context).pushNamed("/generate_qr", arguments: args);
    }
  }
}
