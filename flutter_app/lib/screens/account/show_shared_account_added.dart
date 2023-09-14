import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/general/my_button.dart';

import 'package:flutter_app/widgets/general/my_text.dart';

class ShowSharedAccountAddedScreen extends StatefulWidget {
  static const String routeName = showSharedAccountAddedRouteName;

  const ShowSharedAccountAddedScreen({Key? key}) : super(key: key);

  @override
  State<ShowSharedAccountAddedScreen> createState() =>
      _ShowSharedAccountAddedScreenState();
}

class _ShowSharedAccountAddedScreenState
    extends State<ShowSharedAccountAddedScreen> {
  @override
  Widget build(BuildContext context) {
    final Account sharedAccount =
        ModalRoute.of(context)?.settings.arguments as Account;

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
              text: 'Cuenta compartida',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              color: sharedAccount.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCard(
                    account: sharedAccount,
                    addButtons: 1,
                    showIsShared: false,
                  )),
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Volver a cuentas',
              function: () => _goAccountManagement(context),
              size: const Size(180, 60),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void _goAccountManagement(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        homeLoggedRouteName, (Route<dynamic> route) => false);
    Navigator.of(context).pushNamed(accountManagementRouteName);
  }
}
