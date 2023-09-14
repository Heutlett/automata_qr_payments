import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/general/my_button.dart';

import 'package:flutter_app/widgets/general/my_text.dart';

class ShowSelectedAccountsScreen extends StatefulWidget {
  static const String routeName = showSelectedAccountsRouteName;

  const ShowSelectedAccountsScreen({Key? key}) : super(key: key);

  @override
  State<ShowSelectedAccountsScreen> createState() =>
      _ShowSelectedAccountsScreenState();
}

class _ShowSelectedAccountsScreenState
    extends State<ShowSelectedAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> data =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    final List<Account> cuentas = data[0];

    final Account accountEmisor = cuentas[0];
    final Account accountReceptor = cuentas[1];
    final String receptorModelName = data[1];
    final List<double> receptorLocation = data[2];
    String receptorTimeStamp = data[3];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas seleccionadas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const MyText(
              text: 'Cuenta emisor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              color: accountEmisor.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCard(
                    account: accountEmisor,
                    addButtons: 1,
                    showIsShared: true,
                  )),
            ),
            const SizedBox(height: 20),
            const MyText(
              text: 'Cuenta receptor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              color: accountReceptor.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCard(
                    account: accountReceptor,
                    addButtons: 1,
                    showIsShared: false,
                  )),
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Crear factura',
              function: () => _showCreateFactura(
                context,
                accountEmisor,
                accountReceptor,
                receptorModelName,
                receptorLocation,
                receptorTimeStamp,
              ),
              size: const Size(170, 60),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void _showCreateFactura(
    BuildContext context,
    Account accountEmisor,
    Account accountReceptor,
    String receptorModelName,
    List<double> receptorLocation,
    String receptorTimeStamp,
  ) {
    Navigator.pushNamed(
      context,
      createFacturaRouteName,
      arguments: [
        accountEmisor,
        accountReceptor,
        receptorModelName,
        receptorLocation,
        receptorTimeStamp,
      ],
    );
  }
}
