import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/account/account_info_card.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

import '../../models/server_response.dart';
import '../utils.dart';
import '../widgets/general/my_text.dart';

class SelectAccountReceptorScreen extends StatefulWidget {
  const SelectAccountReceptorScreen({Key? key}) : super(key: key);

  @override
  State<SelectAccountReceptorScreen> createState() =>
      _SelectAccountReceptorScreenState();
}

class _SelectAccountReceptorScreenState
    extends State<SelectAccountReceptorScreen> {
  @override
  Widget build(BuildContext context) {
    final Account accountEmisor =
        ModalRoute.of(context)?.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const MyText(
              text: 'Cuenta emisor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5,
              color: accountEmisor.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AccountInfoCard(account: accountEmisor),
              ),
            ),
            const SizedBox(height: 50),
            const MyText(
              text: 'Cuenta receptor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Escanear QR de receptor',
              function: () => scanQR(context),
              icon: Icons.qr_code_scanner,
              backgroundColor: Colors.green,
              size: const Size(290, 50),
            ),
          ],
        ),
      ),
    );
  }

  void showSelectAccountManagement(
      BuildContext context, String codigoQr) async {
    ServerResponse<Account?> getCuenta = await getCuentaByQr(codigoQr);

    Account? accountReceptor = getCuenta.data;

    if (context.mounted) {
      if (accountReceptor == null || !getCuenta.success) {
        showAlertDialog(context, 'Error', getCuenta.message, 'Ok');
      } else {
        final Account accountEmisor =
            ModalRoute.of(context)?.settings.arguments as Account;

        List<Account> cuentas = [accountEmisor, accountReceptor];

        Navigator.of(context)
            .pushNamed("/select_account_management", arguments: cuentas);
      }
    }
  }

  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (context.mounted) {
        showSelectAccountManagement(context, barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
