import 'package:flutter/material.dart';
import '/models/account.dart';
import '/screens/widgets/general/my_button.dart';
import '/screens/widgets/account/account_info_card.dart';

import '../widgets/general/my_text.dart';

class SelectAccountManagementScreen extends StatefulWidget {
  const SelectAccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<SelectAccountManagementScreen> createState() =>
      _SelectAccountManagementScreenState();
}

class _SelectAccountManagementScreenState
    extends State<SelectAccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    final accountEmisor = accounts[0];
    final accountReceptor = accounts[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de cuentas'),
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
                  )),
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Crear factura',
              function: () => _showCreateFactura(
                context,
                accountEmisor,
                accountReceptor,
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
  ) {
    Navigator.pushNamed(context, '/create_factura',
        arguments: [accountEmisor, accountReceptor]);
  }
}
