import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import '../../services/cuenta/cuenta_service.dart';
import '../widgets/general/my_button.dart';
import '../widgets/account/account_info_card.dart';
import '../widgets/account/account_info_card_buttons.dart';

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
            const Text('Mis cuentas'),
            MyButton(
              text: 'Crear',
              function: () => _createAccount(context),
              icon: Icons.add_circle,
              size: const Size(120, 40),
              backgroundColor: Colors.green,
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
                      AccountInfoCard(account: acc),
                      const AccountInfoCardButtons()
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

  void _editAccount() {
    // Aquí implementa la lógica para editar una cuenta existente
  }

  void _deleteAccount() {
    // Aquí implementa la lógica para borrar una cuenta existente
  }
}
