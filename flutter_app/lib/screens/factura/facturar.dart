import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class FacturarScreen extends StatelessWidget {
  static const String routeName = facturarRouteName;

  const FacturarScreen({Key? key}) : super(key: key);

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
              function: () => _showSelectAccountReceptorForQr(context),
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectAccountReceptorForQr(BuildContext context) async {
    var accounts = await getAccountList();

    if (context.mounted) {
      Navigator.of(context).pushNamed(generateQrRouteName, arguments: accounts);
    }
  }

  void _showSelectAccount(BuildContext context) async {
    List<Account> accounts = await getAccountList();

    if (context.mounted) {
      Navigator.of(context)
          .pushNamed(selectEmisorAccountRouteName, arguments: accounts);
    }
  }
}
