import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

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

    print("prueba");
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
                    child: Text('Escanear QR de receptor'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  color: Colors.red[100],
                  //width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showSelectAccountManagementTemporal(context);
                          },
                          child: Text('Simular escaneo QR de receptor'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Nombre de usuario',
                                ),
                                controller: _usernameController,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Id cuenta',
                                ),
                                controller: _idCuentaController,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSelectAccountManagementTemporal(BuildContext context) async {
    final String username = _usernameController.text;
    final String idCuenta = _idCuentaController.text;

    var account_receptor = await getCuentaTemporal(username, idCuenta);

    final Account account_emisor =
        ModalRoute.of(context)?.settings.arguments as Account;

    List<Account> cuentas = [account_emisor, account_receptor];

    Navigator.of(context)
        .pushNamed("/select_account_management", arguments: cuentas);
  }

  void showSelectAccountManagement(
      BuildContext context, String codigoQr) async {
    var response = await getCuentaByQr(codigoQr);

    var data = jsonDecode(response.body);

    if (!data['success']) {
      showAlertDialog(context, "Resultado", data['success'], data['message']);
      return;
    }

    data = data['data'];
    Account accountReceptor = Account(
        id: data['id'].toString(),
        cedulaTipo: data['cedulaTipo'],
        cedulaNumero: data['cedulaNumero'],
        idExtranjero: data['idExtranjero'],
        nombre: data['nombre'],
        nombreComercial: data['nombreComercial'],
        telCodigoPais: data['telCodigoPais'],
        telNumero: data['telNumero'],
        faxCodigoPais: data['faxCodigoPais'],
        faxNumero: data['faxNumero'],
        correo: data['correo'],
        ubicacionCodigo: data['ubicacionCodigo'],
        ubicacionSenas: data['ubicacionSenas'],
        ubicacionSenasExtranjero: data['ubicacionSenasExtranjero'],
        tipo: data['tipo']);

    final Account account_emisor =
        ModalRoute.of(context)?.settings.arguments as Account;

    List<Account> cuentas = [account_emisor, accountReceptor];

    Navigator.of(context)
        .pushNamed("/select_account_management", arguments: cuentas);
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
