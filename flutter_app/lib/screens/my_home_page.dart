import 'package:flutter/material.dart';
import 'package:flutter_app/screens/demo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: Text('QR Payments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido a QR Payments!',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showRegistrationPage(context);
              },
              child: Text('Registrarse', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showLoginPage(context);
              },
              child: Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showDemoPage(context);
              },
              child: Text('Mostrar Demo', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDemoPage(BuildContext context) {
    Navigator.of(context).pushNamed("/demo");
  }

  void _showRegistrationPage(BuildContext context) {
    Navigator.of(context).pushNamed("/register");
  }

  void _showLoginPage(BuildContext context) {
    Navigator.of(context).pushNamed("/login");
  }
}
