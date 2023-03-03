import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/services/usuario/usuario_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;

    var response = await postRegister(username, password, email);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      showAlertDialog(context, data['success'], data['message']);
    } else {
      showAlertDialog(context, data['success'], data['message']);
    }
  }

  void showAlertDialog(BuildContext context, bool success, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    var title = "Resultado de registro";
    var text = message;

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
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
              'Regístrate para empezar',
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
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () => {_submitForm(context)},
              child: Text('Registrarse'),
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
