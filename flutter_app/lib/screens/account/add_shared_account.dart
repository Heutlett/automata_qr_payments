import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';

class AddSharedAccountScreen extends StatefulWidget {
  static const String routeName = addSharedAccountRouteName;

  const AddSharedAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddSharedAccountScreen> createState() => _AddSharedAccountScreenState();
}

class _AddSharedAccountScreenState extends State<AddSharedAccountScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas compartidas'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carga
          : SingleChildScrollView(
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
                      function: () => _scanQR(context, providerManager),
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

  void _setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  void _showSharedAccountAddedScreen(BuildContext context, String codigoQr,
      ProviderManager providerManager) async {
    _setLoadingTrue();
    ServerResponse<Account?> serverResponse =
        await postAddSharedAccountByQr(codigoQr);
    _setLoadingFalse();

    if (serverResponse.success) {
      Account addedSharedAccount = serverResponse.data!;
      providerManager.setAddedSharedAccount(addedSharedAccount);

      if (context.mounted) {
        Navigator.of(context).pushNamed(showSharedAccountAddedRouteName);
      }
    } else {
      if (context.mounted) {
        showAlertDialog(context, 'Error', serverResponse.message, 'Ok');
      }
    }
  }

  Future<void> _scanQR(
      BuildContext context, ProviderManager providerManager) async {
    String qrCodeScanedResponse;

    try {
      qrCodeScanedResponse = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (context.mounted) {
        _showSharedAccountAddedScreen(
            context, qrCodeScanedResponse, providerManager);
      }
    } on PlatformException {
      qrCodeScanedResponse = 'Failed to get platform version.';
    }
  }
}
