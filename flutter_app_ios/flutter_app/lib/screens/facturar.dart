import 'package:flutter/material.dart';
import '/models/account.dart';
import '/services/cuenta/cuenta_service.dart';

import 'widgets/general/my_button.dart';
import 'widgets/general/my_text.dart';

class FacturarPage extends StatelessWidget {
  const FacturarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
              text: 'Seleccione una opcion:',
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 40.0),
            MyButton(
              text: 'Crear factura emisor',
              function: () => _showSelectAccount(context),
              fontSize: 16,
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Generar QR receptor',
              function: () => _showSelectAccountsQr(context),
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectAccountsQr(BuildContext context) async {
    var accounts = await getCuentasList();

    if (context.mounted) {
      Navigator.of(context)
          .pushNamed("/select_account_qr", arguments: accounts);
    }
  }

  void _showSelectAccount(BuildContext context) async {
    List<Account> accounts = await getCuentasList();

    if (context.mounted) {
      Navigator.of(context)
          .pushNamed("/select_account_emisor", arguments: accounts);
    }
  }
}
