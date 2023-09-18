import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SelectReceptorAccountToGenerateQrScreen extends StatefulWidget {
  static const String routeName = selectReceptorAccountToGenerateQrRouteName;

  const SelectReceptorAccountToGenerateQrScreen({super.key});

  @override
  State<SelectReceptorAccountToGenerateQrScreen> createState() =>
      _SelectReceptorAccountToGenerateQrScreenState();
}

class _SelectReceptorAccountToGenerateQrScreenState
    extends State<SelectReceptorAccountToGenerateQrScreen> {
  List<Account>? accounts;

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    final providerManager = Provider.of<ProviderManager>(context);
    accounts = providerManager.myAccounts;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione su cuenta receptor'),
      ),
      body: accounts == null || isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: accounts!.map((acc) {
                        return Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 5,
                              color: acc.cedulaTipo == 'Juridica'
                                  ? const Color.fromARGB(255, 180, 193, 255)
                                  : const Color.fromARGB(255, 180, 234, 255),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AccountInfoCard(
                                      account: acc,
                                      addButtons: 1,
                                      showIsShared: true,
                                    ),
                                  ),
                                  MyButton(
                                    text: 'Seleccionar',
                                    function: () =>
                                        _showGenerateQrScreen(context, acc),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
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

  void _showGenerateQrScreen(BuildContext context, Account account) async {
    _setLoadingTrue();
    var accountEncryptedCode = await getAccountBillingQr(int.parse(account.id));
    var receptorModelName = await getDeviceModel();
    var receptorLocation = await getLocation();
    _setLoadingFalse();
    var receptorTimeStamp = DateTime.now().toIso8601String();

    String codigoQr =
        '$accountEncryptedCode $receptorModelName ${receptorLocation[0]} ${receptorLocation[1]} $receptorTimeStamp';

    var args = [
      account.cedulaTipo,
      account.cedulaNumero,
      account.nombre,
      codigoQr,
    ];

    if (context.mounted) {
      Navigator.of(context).pushNamed(showReceptorQrRouteName, arguments: args);
    }
  }
}
