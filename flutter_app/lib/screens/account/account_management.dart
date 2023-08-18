import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/screens/widgets/account/account_info_card.dart';

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
            ElevatedButton(
              onPressed: () {
                _createAccount(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('Cuenta'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addSharedAccount(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple)),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('Cuenta compartida'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: accounts == null
                ? const [CircularProgressIndicator()] // Indicador de carga
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
      ),
    );
  }

  void _createAccount(BuildContext context) async {
    Navigator.of(context).pushNamed("/create_account");
  }

  void _addSharedAccount(BuildContext context) async {
    Navigator.of(context).pushNamed("/add_shared_account");
  }
}
