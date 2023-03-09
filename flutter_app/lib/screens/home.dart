import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/my_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
                text: '¡Bienvenido a QR Payments!',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
            const SizedBox(height: 40.0),
            MyButton(
              text: 'Registrarse',
              function: _showRegistrationPage,
              fontSize: 18,
              size: const Size(200, 60),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Iniciar sesión',
              function: _showLoginPage,
              fontSize: 18,
              size: const Size(200, 60),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _showRegistrationPage(BuildContext context) {
    Navigator.of(context).pushNamed("/register");
  }

  Future<void> _showLoginPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('lastUsername');

    if (context.mounted) {
      Navigator.of(context).pushNamed("/login", arguments: userName);
    }
  }
}
