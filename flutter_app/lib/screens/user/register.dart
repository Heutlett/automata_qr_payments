import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'dart:convert';
import 'package:flutter_app/services/usuario/usuario_service.dart';

import 'package:flutter_app/utils/utils.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = registerRouteName;

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(registerTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu nombre completo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de usuario *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu nombre de usuario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico *',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu correo electrónico';
                          }
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Por favor, ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40.0),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitRegisterForm(context);
                              }
                            },
                            child: const Text('Registrarse',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _submitRegisterForm(BuildContext context) async {
    final String username = _usernameController.text;
    final String name = _nameController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;

    setState(() {
      isLoading = true;
    });

    var response = await postRegister(username, name, password, email);
    var data = jsonDecode(response.body);

    setState(() {
      isLoading = false;
    });

    if (context.mounted) {
      if (response.statusCode == 200) {
        showAlertDialogWithRoute(
            context, 'Resultado registro', data['message'], 'Ok', "/");
      } else {
        showAlertDialog(context, 'Resultado registro', data['message'], 'Ok');
      }
    }
  }
}
