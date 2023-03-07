import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

class FacturarPage extends StatelessWidget {
  const FacturarPage({Key? key}) : super(key: key);

  void _showSelectAccount(BuildContext context) async {
    List<Account> accounts = await getCuentasList();
    Navigator.of(context)
        .pushNamed("/select_account_emisor", arguments: accounts);
  }

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
            const Text(
              'Seleccione una opcion:',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showSelectAccount(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 60),
              ),
              child: const Text('Crear factura emisor',
                  style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showSelectAccountsQr(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 60),
              ),
              child: const Text('Generar QR receptor',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectAccountsQr(BuildContext context) async {
    var accounts = await getCuentasList();

    Navigator.of(context).pushNamed("/select_account_qr", arguments: accounts);
  }
}
