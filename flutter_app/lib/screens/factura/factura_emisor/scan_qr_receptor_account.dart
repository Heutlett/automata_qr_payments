import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';

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
        title: const Text('Escaneo de QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _scanQR(context),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Escanear QR de receptor',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.qr_code_scanner,
                      size: 150,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectAccountManagement(
      BuildContext context, String codigoQr) async {
    List<String> codigoQrParts = codigoQr.split(" ");
    var accountEncryptedCode = codigoQrParts[0];
    try {
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
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAlertDialog(context, 'A ocurrido un error', e.toString(), 'Ok');
    }
  }

  Future<void> _scanQR(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);

      if (barcodeScanRes != '-1' && context.mounted) {
        _showSelectAccountManagement(context, barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      showAlertDialog(context, 'Error', e.toString(), 'Ok');
    }
  }
}
