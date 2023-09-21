import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/managers/shared_local_store.dart';
import 'dart:convert';
import 'package:flutter_app/services/user/user_service.dart';

import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = loginRouteName;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberUsername = false;
  late String _lastUsername;
  late ProviderManager providerManager;

  bool isLoading = false;

  @override
  void initState() {
    _loadLastUsername();
    super.initState();
  }

  _loadLastUsername() async {
    _lastUsername = await SharedLocalStore.getLastUsername();
    if (_lastUsername.isNotEmpty) {
      setState(() {
        _usernameController.text = _lastUsername;
        _rememberUsername = true;
      });
    } else {
      setState(() {
        _rememberUsername = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    providerManager = Provider.of<ProviderManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginTitle),
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
                      const SizedBox(height: 20.0),
                      const MyText(
                        text: homeWelcomeTitle,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de usuario',
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
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberUsername,
                            onChanged: (value) {
                              setState(() {
                                _rememberUsername = value!;
                              });
                            },
                          ),
                          const Text('Recordar nombre de usuario'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitLoginForm(context, providerManager);
                            }
                          },
                          child: const Text('Iniciar sesión',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _submitLoginForm(
    BuildContext context,
    ProviderManager providerManager,
  ) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      _setLoadingTrue();
      var response = await postLogin(username, password);
      _setLoadingFalse();

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var accessToken = data['data'];

        _setLoadingTrue();
        // Se guarda el accessToken en el local storage
        await SharedLocalStore.setAccessToken(accessToken);

        if (_rememberUsername) {
          // Se guarda el username en el local storage
          await SharedLocalStore.setUserLastUsername(username);
        } else {
          // Se resetea el username del local storage
          await SharedLocalStore.resetLastUsername();
        }
        _setLoadingFalse();

        // Se carga la pantalla de homeLogged
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              homeLoggedRouteName, (Route<dynamic> route) => false);
        }
      } else {
        // Limpia la contraseña del form
        _passwordController.clear();

        if (response.statusCode == 404) {
          if (context.mounted) {
            showAlertDialog(context, "Resultado de inicio sesion",
                'Ha ocurrido un error con el servidor.', 'Ok');
          }
        } else if (context.mounted) {
          var data = jsonDecode(response.body);
          showAlertDialog(
              context, "Resultado de inicio sesion", data['message'], 'Ok');
        }
      }
    } catch (e) {
      _setLoadingFalse();
      showAlertDialog(
          context, 'Resultado de inicio sesion', e.toString(), 'Ok');
    }
  }
}
