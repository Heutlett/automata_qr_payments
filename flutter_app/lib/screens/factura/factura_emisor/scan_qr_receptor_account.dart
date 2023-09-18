import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class ScanQrReceptorAccountScreen extends StatefulWidget {
  static const String routeName = scanQrReceptorAccountRouteName;

  const ScanQrReceptorAccountScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrReceptorAccountScreen> createState() =>
      _ScanQrReceptorAccountScreenState();
}

class _ScanQrReceptorAccountScreenState
    extends State<ScanQrReceptorAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
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
      ),
    );
  }

  void _showSelectAccountManagement(
      BuildContext context, String codigoQr) async {
    List<String> codigoQrParts = codigoQr.split(" ");
    var accountEncryptedCode = codigoQrParts[0];

    ServerResponse<Account?> getCuenta =
        await getCuentaByQr(accountEncryptedCode);

    Account? receptorAccount = getCuenta.data;

    if (context.mounted) {
      if (receptorAccount == null || !getCuenta.success) {
        showAlertDialog(context, 'Error', getCuenta.message, 'Ok');
      } else {
        Navigator.of(context).pushNamed(
          showSelectedAccountsRouteName,
          arguments: receptorAccount,
        );
      }
    }
  }

  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (context.mounted) {
        _showSelectAccountManagement(context, barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
