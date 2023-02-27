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

  final _cedulaNumeroController = TextEditingController();
  final _idExtranjeroController = TextEditingController();
  final _nombreController = TextEditingController();
  final _nombreComercialController = TextEditingController();
  final _telCodigoPaisController = TextEditingController();
  final _telNumeroController = TextEditingController();
  final _faxCodigoPaisController = TextEditingController();
  final _faxNumeroController = TextEditingController();
  final _correoController = TextEditingController();
  final _ubicacionCodigoController = TextEditingController();
  final _ubicacionSenasController = TextEditingController();
  final _ubicacionSenasExtranjeroController = TextEditingController();

  @override
  void dispose() {
    _cedulaNumeroController.dispose();
    _idExtranjeroController.dispose();
    _nombreController.dispose();
    _nombreComercialController.dispose();
    _telCodigoPaisController.dispose();
    _telNumeroController.dispose();
    _faxCodigoPaisController.dispose();
    _faxNumeroController.dispose();
    _correoController.dispose();
    _ubicacionCodigoController.dispose();
    _ubicacionSenasController.dispose();
    _ubicacionSenasExtranjeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Account account =
        ModalRoute.of(context)?.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: Text('Creación de factura emisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountForm(
              titulo: 'Datos emisor',
              account: account,
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> _getCuentas() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var url = "http://10.0.2.2:5275/api/Cuenta/GetAll";

    var headers = {"Authorization": "bearer $token"};

    var response = await http.get(Uri.parse(url), headers: headers);

    return response;
  }

  void _showAccountManagement(BuildContext context) async {
    var response = await _getCuentas();
    var data = jsonDecode(response.body);

    Navigator.of(context)
        .pushNamed("/account_management", arguments: data['data']);
  }

  void _submitForm() async {}
}
