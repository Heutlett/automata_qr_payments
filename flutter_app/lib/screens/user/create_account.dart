import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/services/usuario/usuario_service.dart';

class AgregarCuentaForm extends StatefulWidget {
  @override
  _AgregarCuentaFormState createState() => _AgregarCuentaFormState();
}

class _AgregarCuentaFormState extends State<AgregarCuentaForm> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar cuenta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: _cedulaTipo,
                  decoration: InputDecoration(
                    labelText: 'Tipo de cédula',
                  ),
                  items: _cedulaTipos
                      .map((cedulaTipo) => DropdownMenuItem(
                            value: cedulaTipo,
                            child: Text(cedulaTipo),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _cedulaTipo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cedulaNumeroController,
                  decoration: InputDecoration(labelText: 'Número de cédula'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _idExtranjeroController,
                  decoration:
                      InputDecoration(labelText: 'ID extranjero (opcional)'),
                ),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nombreComercialController,
                  decoration:
                      InputDecoration(labelText: 'Nombre comercial (opcional)'),
                ),
                TextFormField(
                  controller: _telCodigoPaisController,
                  decoration:
                      InputDecoration(labelText: 'Código de país del teléfono'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telNumeroController,
                  decoration: InputDecoration(labelText: 'Número de teléfono'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _faxCodigoPaisController,
                  decoration: InputDecoration(
                      labelText: 'Código de país del fax (opcional)'),
                ),
                TextFormField(
                  controller: _faxNumeroController,
                  decoration:
                      InputDecoration(labelText: 'Número de fax (opcional)'),
                ),
                TextFormField(
                  controller: _correoController,
                  decoration: InputDecoration(labelText: 'Correo electrónico'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ubicacionCodigoController,
                  decoration: InputDecoration(labelText: 'Código de ubicación'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ubicacionSenasController,
                  decoration:
                      InputDecoration(labelText: 'Señas de la ubicación'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ubicacionSenasExtranjeroController,
                  decoration: InputDecoration(
                      labelText: 'Señas de la ubicación extranjero (opcional)'),
                ),
                DropdownButtonFormField<String>(
                  value: _tipoCuenta,
                  decoration: InputDecoration(
                    labelText: 'Tipo de cuenta',
                  ),
                  items: _tiposCuenta
                      .map((tipoCuenta) => DropdownMenuItem(
                            value: tipoCuenta,
                            child: Text(tipoCuenta),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipoCuenta = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    child: Text('Agregar cuenta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAccountManagement(BuildContext context) async {
    var cuentas = await getCuentasList();

    Navigator.of(context).pushNamed("/account_management", arguments: cuentas);
  }

  void _submitForm() async {
// Obtener los valores de los campos del formulario
    final cedulaTipo = _cedulaTipo;
    final cedulaNumero = _cedulaNumeroController.text;
    final idExtranjero = _idExtranjeroController.text;
    final nombre = _nombreController.text;
    final nombreComercial = _nombreComercialController.text;
    final telCodigoPais = _telCodigoPaisController.text;
    final telNumero = _telNumeroController.text;
    final faxCodigoPais = _faxCodigoPaisController.text;
    final faxNumero = _faxNumeroController.text;
    final correo = _correoController.text;
    final ubicacionCodigo = _ubicacionCodigoController.text;
    final ubicacionSenas = _ubicacionSenasController.text;
    final ubicacionSenasExtranjero = _ubicacionSenasExtranjeroController.text;
    final tipo = _tipoCuenta;

    // Crear un mapa con los valores de la cuenta
    final cuenta = {
      "cedulaTipo": cedulaTipo,
      "cedulaNumero": cedulaNumero,
      "idExtranjero": idExtranjero,
      "nombre": nombre,
      "nombreComercial": nombreComercial,
      "telCodigoPais": telCodigoPais,
      "telNumero": telNumero,
      "faxCodigoPais": faxCodigoPais,
      "faxNumero": faxNumero,
      "correo": correo,
      "ubicacionCodigo": ubicacionCodigo,
      "ubicacionSenas": ubicacionSenas,
      "ubicacionSenasExtranjero": ubicacionSenasExtranjero,
      "tipo": tipo
    };

    print(cuenta);

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var response = await postCreateAccount(cuenta, token);

// Si la respuesta es exitosa, mostrar un mensaje de éxito
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Cuenta agregada'),
          content: Text('La cuenta se agregó exitosamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _showAccountManagement(context);
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      // Si la respuesta no es exitosa, mostrar un mensaje de error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error al agregar cuenta'),
          content: Text('Ocurrió un error al agregar la cuenta.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }
}
