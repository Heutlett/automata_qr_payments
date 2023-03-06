import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

import '../../../models/serverResponse.dart';

class SelectAccountReceptorScreen extends StatefulWidget {
  const SelectAccountReceptorScreen({Key? key}) : super(key: key);

  @override
  State<SelectAccountReceptorScreen> createState() =>
      _SelectAccountReceptorScreenState();
}

class _SelectAccountReceptorScreenState
    extends State<SelectAccountReceptorScreen> {
  // Esto es temporal, sebe cambiar por metodo seguro
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _idCuentaController = TextEditingController();

  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      print(barcodeScanRes);
      showSelectAccountManagement(context, barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Account account_emisor =
        ModalRoute.of(context)?.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cuenta emisor',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    color: account_emisor.cedulaTipo == 'Juridica'
                        ? Color.fromARGB(255, 163, 152, 245)
                        : Color.fromARGB(255, 152, 207, 245),
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account_emisor.cedulaTipo,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Text(
                            account_emisor.cedulaNumero,
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(height: 16),
                          Text(
                            account_emisor.nombre,
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cambiar a otra cuenta'))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cuenta receptor',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      scanQR(context);
                    },
                    child: Center(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Escanear QR de receptor',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.qr_code_scanner,
                              size: 100,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                  ),
                ),
              ],
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

    if (accountReceptor == null || !getCuenta.success) {
      showAlertDialog(context, 'Error', false, getCuenta.message);
    } else {
      final Account account_emisor =
          ModalRoute.of(context)?.settings.arguments as Account;

      List<Account> cuentas = [account_emisor, accountReceptor];

      Navigator.of(context)
          .pushNamed("/select_account_management", arguments: cuentas);
    }
  }

  void showAlertDialog(
      BuildContext context, String title, bool success, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
