import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/general/my_button.dart';

import 'package:flutter_app/widgets/general/my_text.dart';
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
  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta agregada'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const MyText(
                    text: 'Cuenta compartida',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
                  MyButton(
                    text: 'Volver a cuentas',
                    function: () =>
                        _goAccountManagement(context, providerManager),
                    size: const Size(180, 60),
                  ),
                  const SizedBox(height: 20)
                ],
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

  Future<void> _loadAccounts(ProviderManager providerManager) async {
    var loadedAccounts = await getAccountList();
    providerManager.setMyAccounts(loadedAccounts);
  }

  Future<void> _showAccountManagementScreen(
      BuildContext context, ProviderManager providerManager) async {
    _setLoadingTrue();
    await _loadAccounts(providerManager);
    _setLoadingFalse();

    if (context.mounted) {
      Navigator.of(context).pushNamed(accountManagementRouteName);
    }
  }

  void _goAccountManagement(
      BuildContext context, ProviderManager providerManager) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        homeLoggedRouteName, (Route<dynamic> route) => false);
    _showAccountManagementScreen(context, providerManager);
  }
}
