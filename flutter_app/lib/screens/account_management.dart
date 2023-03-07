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
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mis cuentas'),
            ElevatedButton(
                onPressed: () {
                  _createAccount();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(
                      width: 9,
                    ),
                    Text('Crear'),
                  ],
                ))
          ],
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: accounts.map((acc) {
                return Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    color: acc.cedulaTipo == 'Juridica'
                        ? Color.fromARGB(255, 180, 193, 255)
                        : Color.fromARGB(255, 180, 234, 255),
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    acc.cedulaTipo,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    acc.cedulaNumero,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    acc.nombre,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Actividades económicas',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(Icons.add_circle,
                                                  color: Colors.green),
                                              SizedBox(width: 8),
                                              Text(
                                                "Agregar",
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: acc.actividades!.length != 0
                                        ? Column(
                                            children: acc.actividades!.map(
                                              (act) {
                                                return Container(
                                                  width: double.infinity,
                                                  child: Card(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  act.codigoActividad,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            act.nombre,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            child: Text(
                                              'No cuenta con actividades económicas',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.open_in_full),
                                          SizedBox(width: 8),
                                          Text("Expandir"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.amber[900],
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Editar",
                                            style: TextStyle(
                                              color: Colors.amber[900],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text(
                                            "Eliminar",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
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
