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

class AddSharedAccountScreen extends StatefulWidget {
  static const String routeName = addSharedAccountRouteName;

  const AddSharedAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddSharedAccountScreen> createState() => _AddSharedAccountScreenState();
}

class _AddSharedAccountScreenState extends State<AddSharedAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas compartidas'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const MyText(
                text: 'Agregar cuenta compartida',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Escanear QR de la cuenta',
                function: () => _scanQR(context),
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

  void _showAddedAccount(BuildContext context, String codigoQr) async {
    ServerResponse<Account?> getCuenta = await shareAccountByQr(codigoQr);

    Account? sharedAccount = getCuenta.data;

    if (context.mounted) {
      if (sharedAccount == null || !getCuenta.success) {
        showAlertDialog(context, 'Error', getCuenta.message, 'Ok');
      } else {
        Account cuenta = sharedAccount;

        Navigator.of(context)
            .pushNamed(showSharedAccountAddedRouteName, arguments: cuenta);
      }
    }
  }

  Future<void> _scanQR(BuildContext context) async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (context.mounted) {
        _showAddedAccount(context, barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
