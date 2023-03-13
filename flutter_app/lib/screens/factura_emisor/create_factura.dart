import 'package:flutter/material.dart';
import '../account/accounts_form.dart';
import 'package:flutter_app/models/account.dart';

class CreateFactura extends StatefulWidget {
  const CreateFactura({super.key});

  @override
  State<CreateFactura> createState() => _CreateFacturaState();
}

class _CreateFacturaState extends State<CreateFactura> {
  String? cedulaTipo;
  String? tipoCuenta;
  final List<String> cedulaTipos = [
    'Fisica',
    'Juridica',
    'DIMEX',
    'NITE',
  ];
  final List<String> tiposCuenta = [
    'Receptor',
    'Emisor',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Account> account =
        ModalRoute.of(context)?.settings.arguments as List<Account>;
    final Account accountEmisor = account[0];
    final Account accountReceptor = account[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación de factura emisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountForm(
              titulo: 'Datos emisor',
              account: accountEmisor,
            ),
            AccountForm(
              titulo: 'Datos receptor',
              account: accountReceptor,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {}, child: const Text('Crear factura')),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
