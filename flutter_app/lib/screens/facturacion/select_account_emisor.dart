import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';

class SelectAccountEmisorScreen extends StatefulWidget {
  const SelectAccountEmisorScreen({Key? key}) : super(key: key);

  @override
  State<SelectAccountEmisorScreen> createState() =>
      _SelectAccountEmisorScreenState();
}

class _SelectAccountEmisorScreenState extends State<SelectAccountEmisorScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Account> accounts =
        ModalRoute.of(context)?.settings.arguments as List<Account>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Creación de factura emisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Seleccione su cuenta emisor',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
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
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  "/select_account_receptor",
                                  arguments: acc);
                            },
                            child: Text('Seleccionar'),
                          ),
                          SizedBox(height: 16),
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
}
