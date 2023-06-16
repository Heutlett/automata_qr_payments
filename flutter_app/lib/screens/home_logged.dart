import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

import 'widgets/general/my_button.dart';
import 'widgets/general/my_text.dart';

class HomeLoggedPage extends StatelessWidget {
  const HomeLoggedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: '¡Bienvenido a QR Payments!',
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 40.0),
            MyButton(
              text: 'Administrar cuentas',
              function: () => _showAccountManagementPage(context),
              size: const Size(250, 60),
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Facturar',
              function: () => _showFacturarPage(context),
              size: const Size(250, 60),
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Historial de pagos',
              function: () => _createAccount(context),
              size: const Size(250, 60),
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Cerrar sesión',
              function: () => _showHomePage(context),
              size: const Size(250, 60),
            ),
          ],
        ),
      ),
    );
  }

  void _createAccount(BuildContext context) async {
    var provinciasResponse = await getProvincias();

    if (context.mounted) {
      if (provinciasResponse.success) {
        var provinciasList = provinciasResponse.data;
        Navigator.of(context).pushNamed("/records", arguments: provinciasList);
      }
    }
  }

  void _showHomePage(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void _showFacturarPage(BuildContext context) {
    Navigator.of(context).pushNamed("/facturar");
  }

  void _showRecordsPage(BuildContext context) {
    Navigator.of(context).pushNamed("/records");
  }

  Future<void> _showAccountManagementPage(BuildContext context) async {
    List<Account> accounts = await getCuentasList();
    if (context.mounted) {
      Navigator.of(context)
          .pushNamed("/account_management", arguments: accounts);
    }
  }
}
