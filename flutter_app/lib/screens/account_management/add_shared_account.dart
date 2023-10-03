import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';
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
        title: const Text('Agregar cuenta compartida'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carga
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _scanQR(context, providerManager),
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Escanear QR cuenta compartida',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w400),
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
    try {
      _setLoadingTrue();
      ServerResponse<Account?> response =
          await postAddSharedAccountByQr(codigoQr);
      _setLoadingFalse();

      if (response.success) {
        if (response.data != null) {
          Account addedSharedAccount = response.data!;
          providerManager.setAddedSharedAccount(addedSharedAccount);

          if (context.mounted) {
            Navigator.of(context).pushNamed(showSharedAccountAddedRouteName);
          }
        } else {
          if (context.mounted) {
            showAlertDialog(context, 'Error', response.message, 'Ok');
          }
        }
      } else {
        if (context.mounted) {
          showAlertDialog(context, 'Error', response.message, 'Ok');
        }
      }
    } catch (e) {
      _setLoadingFalse();
      if (context.mounted) {
        showAlertDialog(context, 'Error', e.toString(), 'Ok');
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
