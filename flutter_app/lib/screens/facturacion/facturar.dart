import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

class FacturarPage extends StatelessWidget {
  FacturarPage({Key? key}) : super(key: key);

  void _showSelectAccount(BuildContext context) async {
    List<Account> accounts = await getCuentasList();
    Navigator.of(context).pushNamed("/select_account", arguments: accounts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Payments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seleccione una opcion:',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showSelectAccount(context);
              },
              child:
                  Text('Crear factura emisor', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/generateQR");
              },
              child:
                  Text('Generar QR receptor', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
