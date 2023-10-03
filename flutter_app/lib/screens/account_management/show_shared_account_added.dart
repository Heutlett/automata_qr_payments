import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';

import 'package:provider/provider.dart';

class ShowSharedAccountAddedScreen extends StatefulWidget {
  static const String routeName = showSharedAccountAddedRouteName;

  const ShowSharedAccountAddedScreen({Key? key}) : super(key: key);

  @override
  State<ShowSharedAccountAddedScreen> createState() =>
      _ShowSharedAccountAddedScreenState();
}

class _ShowSharedAccountAddedScreenState
    extends State<ShowSharedAccountAddedScreen> {
  bool isLoading = false;
  final _aliasController = TextEditingController();

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Cuenta agregada')),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8.0),
                  color: providerManager.addedSharedAccount!.cedulaTipo ==
                          'Juridica'
                      ? const Color.fromARGB(255, 180, 193, 255)
                      : const Color.fromARGB(255, 180, 234, 255),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AccountInfoCard(
                        account: providerManager.addedSharedAccount!,
                        addButtons: 1,
                        showIsShared: true,
                      )),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _submitEditAccountAliasForm(
                          context,
                          providerManager.selectedEditAccount!.id,
                          providerManager);

                      _showAccountManagementScreen(context, providerManager);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Guardar y volver a cuentas',
                        style: TextStyle(fontSize: 20),
                      ),
                    ))
              ],
            ),
    );
  }

  void _submitEditAccountAliasForm(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    final alias = _aliasController.text;

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

  Future<void> _showAccountManagementScreen(
      BuildContext context, ProviderManager providerManager) async {
    _setLoadingTrue();
    var loadedAccounts = await getAccountList();
    providerManager.setMyAccounts(loadedAccounts);
    _setLoadingFalse();

    if (context.mounted) {
      providerManager.reloadAccountsInAccountManagement(
          context, loadedAccounts);
    }
  }
}
