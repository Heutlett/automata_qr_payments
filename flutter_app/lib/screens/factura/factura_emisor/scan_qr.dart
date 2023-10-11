import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanQrScreen extends StatefulWidget {
  static const String routeName = scanQrRouteName;

  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    return !isScanned
        ? _showScanQrReceptorScreen(providerManager)
        : _showQrReceptorScreen(providerManager);
  }

  void _showSelectAccountManagement(BuildContext context, String codigoQr,
      ProviderManager providerManager) async {
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
          providerManager.setQrReceptorAccount(receptorAccount);
          setState(() {
            isScanned = true;
          });
          //Navigator.of(context).pushNamed(showSelectedAccountsRouteName);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showAlertDialog(context, 'Ha ocurrido un error', e.toString(), 'Ok');
      }
    }
  }

  Future<void> _scanQR(
      BuildContext context, ProviderManager providerManager) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);

      if (barcodeScanRes != '-1' && context.mounted) {
        _showSelectAccountManagement(context, barcodeScanRes, providerManager);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      showAlertDialog(context, 'Error', e.toString(), 'Ok');
    }
  }

  Scaffold _showScanQrReceptorScreen(ProviderManager providerManager) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneo de QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _scanQR(context, providerManager),
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

  Scaffold _showQrReceptorScreen(ProviderManager providerManager) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta escaneada'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              color: providerManager.qrReceptorAccount!.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCard(
                    account: providerManager.qrReceptorAccount!,
                    addButtons: 1,
                    showIsShared: false,
                  )),
            ),
            const SizedBox(height: 20),
            MyButton(
                function: () => _showHomeLoggedScreen(context, providerManager),
                text: 'Volver al inicio')
          ],
        ),
      ),
    );
  }

  void _showHomeLoggedScreen(
      BuildContext context, ProviderManager providerManager) {
    Navigator.of(context).pop();
  }
}
