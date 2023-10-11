import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditAccountAliasScreen extends StatefulWidget {
  static const String routeName = editAccountAliasRouteName;

  const EditAccountAliasScreen({super.key});

  @override
  State<EditAccountAliasScreen> createState() => _EditAccountAliasScreenState();
}

class _EditAccountAliasScreenState extends State<EditAccountAliasScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool _isInitialized = false;

  final _aliasController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _isInitialized = false;
    });
  }

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    if (!_isInitialized) {
      Account account = providerManager.selectedEditAccount!;
      _aliasController.text = account.alias;
      _isInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cuenta'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carga
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: WillPopScope(
                  onWillPop: () async {
                    // Mostrar AlertDialog cuando se intenta ir hacia atrás o salir de la aplicación
                    bool shouldExit = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('¿Estás seguro?'),
                          content: const Text(
                              'Si sales ahora, perderás el progreso del formulario.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Permanecer en la pantalla actual
                              },
                            ),
                            TextButton(
                              child: const Text('Salir'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(true); // Salir de la pantalla actual
                              },
                            ),
                          ],
                        );
                      },
                    );

                    return shouldExit;
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 232, 232, 232),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            children: [
                              const SizedBox(height: 8.0),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Alias',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _aliasController,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Ingrese un alias para la cuenta'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitEditAccountAliasForm(
                                          context,
                                          providerManager
                                              .selectedEditAccount!.id,
                                          providerManager);
                                    } else {
                                      showAlertDialog(
                                        context,
                                        'Error',
                                        'El formulario se encuentra incompleto o algún campo es incorrecto.',
                                        'Corregir',
                                      );
                                    }
                                  },
                                  child: const Text('Editar cuenta'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  void _submitEditAccountAliasForm(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    final alias = _aliasController.text;
    try {
      _setLoadingTrue();
      var response = await putEditAccountAlias(accountId, alias);
      _setLoadingFalse();

      if (response.statusCode == 200) {
        _setLoadingTrue();
        List<Account> accounts = await mapAccountListResponse(response);
        _setLoadingFalse();
        if (context.mounted) {
          showAlertDialogWithFunction(
            context,
            'Cuenta editada',
            'La cuenta se editó exitosamente.',
            'Aceptar',
            () {
              providerManager.reloadAccountsInAccountManagement(
                  context, accounts);
            },
          );
        }
      } else {
        if (context.mounted) {
          showAlertDialog(
            context,
            'Error al editar cuenta',
            'Ocurrió un error al editar la cuenta.',
            'Aceptar',
          );
        }
      }
    } catch (e) {
      _setLoadingFalse();
      if (context.mounted) {
        showAlertDialog(context, 'Ha ocurrido un error', e.toString(), 'Ok');
      }
    }
  }
}
