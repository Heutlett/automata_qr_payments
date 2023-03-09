import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/services/usuario/usuario_service.dart';

import '../utils.dart';
import '../widgets/general/my_button.dart';
import '../widgets/general/my_text.dart';
import '../widgets/general/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberUsername = false;
  bool _builded = false;

  @override
  Widget build(BuildContext context) {
    final String? lastUsername =
        ModalRoute.of(context)?.settings.arguments as String?;

    // Remember username
    if (lastUsername != null && lastUsername.isNotEmpty && !_builded) {
      _usernameController.text = lastUsername;
      _rememberUsername = true;
      _builded = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const MyText(
              text: 'Bienvenido de nuevo!',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20.0),
            MyTextField(
              labelText: 'Nombre de usuario',
              controller: _usernameController,
            ),
            const SizedBox(height: 20.0),
            MyTextField(
              labelText: 'Contraseña',
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _rememberUsername,
                  onChanged: (value) {
                    recodarUsuario(value);
                  },
                ),
                const Text('Recordar nombre de usuario'),
              ],
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: 'Iniciar sesión',
              function: () => _submitForm(context),
            ),
          ],
        ),
      ),
    );
  }

  void recodarUsuario(bool? value) {
    setState(() {
      _rememberUsername = value!;
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    var response = await postLogin(username, password);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var accessToken = data['data'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);

      if (_rememberUsername) {
        await prefs.setString('lastUsername', _usernameController.text);
      } else {
        await prefs.setString('lastUsername', "");
      }
      if (context.mounted) {
        showAlertDialog(
            context, 'Resultado de inicio sesion', data['message'], 'Ok');

        Navigator.of(context).pushNamed("/home_logged", arguments: username);
      }
    } else {
      if (context.mounted) {
        showAlertDialog(context, "Resultado de inicio sesion", data['success'],
            data['message']);
      }
    }
  }
}
