import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';

import '../services/cuenta/cuenta_service.dart';

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
        title: Text('Administración de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _createAccount();
                  },
                  child: Text('Crear cuenta'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _editAccount();
                  },
                  child: Text('Editar cuenta'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteAccount();
                  },
                  child: Text('Borrar cuenta'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              children: accounts.map((acc) {
                return Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    color: acc.cedulaTipo == 'Juridica'
                        ? Color.fromARGB(255, 163, 152, 245)
                        : Color.fromARGB(255, 152, 207, 245),
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            acc.cedulaTipo,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Text(
                            acc.cedulaNumero,
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(height: 16),
                          Text(
                            acc.nombre,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
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

  void _createAccount() async {
    var cantonesResponse = await getProvincias();
    if (cantonesResponse.success) {
      var cantonesList = cantonesResponse.data;
      Navigator.of(context)
          .pushNamed("/create_account", arguments: cantonesList);
    } else {
      _showDialog(context, 'Error', cantonesResponse.message, 'Aceptar');
    }
  }

  void _editAccount() {
    // Aquí implementa la lógica para editar una cuenta existente
  }

  void _deleteAccount() {
    // Aquí implementa la lógica para borrar una cuenta existente
  }
}
