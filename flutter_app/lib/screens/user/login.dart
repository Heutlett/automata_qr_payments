import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/services/usuario/usuario_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberUsername = false;
  bool _builded = false;

  void _submitForm(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    var response = await postLogin(username, password);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Este es el accessToken
      var accessToken = data['data'];

      // Guardar accessToken en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);

      if (_rememberUsername) {
        // Guardar accessToken en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('lastUsername', _usernameController.text);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('lastUsername', "");
      }

      showAlertDialog(context, "Resultado de inicio sesion", data['success'],
          data['message']);

      Navigator.of(context).pushNamed("/home_logged", arguments: username);
    } else {
      showAlertDialog(context, "Resultado de inicio sesion", data['success'],
          data['message']);
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

  @override
  Widget build(BuildContext context) {
    final String? lastUsername =
        ModalRoute.of(context)?.settings.arguments as String?;

    if (lastUsername != null && lastUsername.isNotEmpty && !_builded) {
      _usernameController.text = lastUsername;
      _rememberUsername = true;
      _builded = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(height: 20.0),
            Text(
              'Bienvenido de nuevo!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
              ),
              controller: _usernameController,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _rememberUsername,
                  onChanged: (value) {
                    recodarUsuario(value);
                  },
                ),
                Text('Recordar nombre de usuario'),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _submitForm(context);
              },
              child: Text('Iniciar sesión'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void recodarUsuario(bool? value) async {
    setState(() {
      _rememberUsername = value!;
    });
  }
}
