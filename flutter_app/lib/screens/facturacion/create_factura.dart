import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'accounts_form.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/models/account.dart';

class CreateFactura extends StatefulWidget {
  @override
  _CreateFacturaState createState() => _CreateFacturaState();
}

class _CreateFacturaState extends State<CreateFactura> {
  final _formKey = GlobalKey<FormState>();

  String? _cedulaTipo;
  String? _tipoCuenta;
  final List<String> _cedulaTipos = [
    'Fisica',
    'Juridica',
    'DIMEX',
    'NITE',
  ];
  final List<String> _tiposCuenta = [
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
        title: Text('Creación de factura emisor'),
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
            SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Crear factura')),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {}
}
