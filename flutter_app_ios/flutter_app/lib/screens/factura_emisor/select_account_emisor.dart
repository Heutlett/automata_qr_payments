import 'package:flutter/material.dart';
import '/models/account.dart';
import '/screens/widgets/general/my_button.dart';

import '../widgets/account/account_info_card.dart';

class SelectAccountEmisorScreen extends StatelessWidget {
  const SelectAccountEmisorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione su cuenta emisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: accounts.map((account) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5,
              color: account.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AccountInfoCard(account: account, addButtons: 1),
                    MyButton(
                      text: 'Seleccionar',
                      function: () =>
                          _showSelectReceptorAccount(context, account),
                      size: const Size(160, 40),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSelectReceptorAccount(BuildContext context, Account account) {
    Navigator.of(context)
        .pushNamed("/select_account_receptor", arguments: account);
  }
}
