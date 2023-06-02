import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_app/screens/widgets/general/my_text_field.dart';
import 'dart:convert';
import 'package:flutter_app/services/usuario/usuario_service.dart';

import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
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
              text: 'Regístrate para empezar',
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
                isPassword: true,
                controller: _passwordController),
            const SizedBox(height: 20.0),
            MyTextField(
              labelText: 'Correo electrónico',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40.0),
            MyButton(
              text: 'Registrarse',
              function: () => _submitForm(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;

    var response = await postRegister(username, password, email);
    var data = jsonDecode(response.body);

    if (context.mounted) {
      if (response.statusCode == 200) {
        showAlertDialog(context, 'Resultado registro', data['message'], 'Ok');
      } else {
        showAlertDialog(context, 'Resultado registro', data['message'], 'Ok');
      }
    }
  }
}
