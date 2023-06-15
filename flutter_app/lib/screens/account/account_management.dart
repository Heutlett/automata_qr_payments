import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_app/screens/widgets/account/account_info_card.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);
  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyButton(
              text: 'Crear cuenta',
              fontSize: 16,
              function: () => _createAccount(context),
              size: const Size(130, 40),
              backgroundColor: Colors.green,
            ),
            MyButton(
              text: 'Agregar cuenta compartida',
              fontSize: 16,
              foregroundColor: Colors.black,
              function: () => {},
              size: const Size(180, 40),
              backgroundColor: Colors.yellow,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: accounts.map(
            (acc) {
              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 5,
                color: acc.cedulaTipo == 'Juridica'
                    ? const Color.fromARGB(255, 180, 193, 255)
                    : const Color.fromARGB(255, 180, 234, 255),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AccountInfoCard(account: acc, addButtons: 2),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  void _showDialog(
      BuildContext context, String title, String content, String textButton) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(textButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createAccount(BuildContext context) async {
    var cantonesResponse = await getProvincias();

    if (context.mounted) {
      if (cantonesResponse.success) {
        var cantonesList = cantonesResponse.data;
        Navigator.of(context)
            .pushNamed("/create_account", arguments: cantonesList);
      } else {
        _showDialog(context, 'Error', cantonesResponse.message, 'Aceptar');
      }
    }
  }
}
