import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_app/screens/widgets/account/account_info_card.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);
  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  List<Account>? accounts;

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void loadAccounts() async {
    var loadedAccounts = await getCuentasList();
    setState(() {
      accounts = loadedAccounts;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          children: accounts == null
              ? [CircularProgressIndicator()] // Indicador de carga
              : accounts!.map((acc) {
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
                }).toList(),
        ),
      ),
    );
  }

  void _createAccount(BuildContext context) async {
    var provinciasResponse = await getProvincias();

    if (context.mounted) {
      if (provinciasResponse.success) {
        var provinciasList = provinciasResponse.data;
        Navigator.of(context)
            .pushNamed("/create_account", arguments: provinciasList);
      } else {
        showAlertDialog(
            context, 'Error', provinciasResponse.message, 'Aceptar');
      }
    }
  }
}
