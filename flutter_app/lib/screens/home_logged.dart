import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

class HomeLoggedPage extends StatelessWidget {
  HomeLoggedPage({Key? key}) : super(key: key);

  void _showAccountManagement(BuildContext context) async {
    List<Account> accounts = await getCuentasList();
    Navigator.of(context).pushNamed("/account_management", arguments: accounts);
  }

  @override
  Widget build(BuildContext context) {
    final String message = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Payments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido ${message}!',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showAccountManagement(context);
              },
              child:
                  Text('Administrar cuentas', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/facturar");
              },
              child: Text('Facturar', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              child: Text('Cerrar sesion', style: TextStyle(fontSize: 18)),
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
