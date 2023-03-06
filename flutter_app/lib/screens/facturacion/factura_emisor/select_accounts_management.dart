import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SelectAccountManagementScreen extends StatefulWidget {
  const SelectAccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<SelectAccountManagementScreen> createState() =>
      _SelectAccountManagementScreenState();
}

class _SelectAccountManagementScreenState
    extends State<SelectAccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    final account_emisor = accounts[0];
    final account_receptor = accounts[1];

    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cuenta emisor',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cuenta receptor',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          color: account_receptor.cedulaTipo == 'Juridica'
                              ? Color.fromARGB(255, 163, 152, 245)
                              : Color.fromARGB(255, 152, 207, 245),
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  account_receptor.cedulaTipo,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  account_receptor.cedulaNumero,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  account_receptor.nombre,
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ])),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create_factura',
                        arguments: [account_emisor, account_receptor]);
                  },
                  child: Text(
                    'Crear factura',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
