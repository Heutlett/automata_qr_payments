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
    final Account accountReceptor =
        ModalRoute.of(context)?.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas escaneada'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                function: () => _showHomeLoggedScreen(context),
                text: 'Volver al inicio')
          ],
        ),
      ),
    );
  }

  void _showHomeLoggedScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
