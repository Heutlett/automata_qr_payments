import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/services/usuario/usuario_service.dart';
import '../../models/actividad.dart';

class AgregarCuentaForm extends StatefulWidget {
  @override
  _AgregarCuentaFormState createState() => _AgregarCuentaFormState();
}

class _AgregarCuentaFormState extends State<AgregarCuentaForm> {
  final _formKey = GlobalKey<FormState>();

  final List<Actividad> actividades = [];

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

  final _codigoActividadController = TextEditingController();

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
    _codigoActividadController.dispose();
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
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 16.0),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Agregar actividades económicas",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _codigoActividadController,
                                  keyboardType: TextInputType
                                      .number, // Esto cambiará el tipo de teclado a numérico
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      labelText: 'Codigo de actividad'),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    addActivity(context);
                                  },
                                  child: Text("Agregar actividad"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        actividades.isEmpty
                            ? SizedBox(width: 16.0)
                            : Column(
                                children: actividades.map((act) {
                                  return Container(
                                    child: Card(
                                      child: Container(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  act.codigoActividad,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(width: 16.0),
                                              Expanded(
                                                flex: 1,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Eliminar"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            act.nombre,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )),
                                    ),
                                  );
                                }).toList(),
                              )
                      ]),
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
      "tipo": tipo,
      "actividades": actividades.map((act) => act.codigoActividad).toList()
    };

    var response = await postCreateAccount(cuenta, actividades);

    if (response.statusCode == 200) {
      _showDialog(context, 'Cuenta agregada',
          'La cuenta se agregó exitosamente.', 'Aceptar');
    } else {
      _showDialog(context, 'Error al agregar cuenta',
          'Ocurrió un error al agregar la cuenta.', 'Aceptar');
    }
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

  void addActivity(BuildContext context) async {
    Actividad? actividad =
        await getActividadByCode(int.parse(_codigoActividadController.text));

    if (actividad != null) {
      bool containsActividad = actividades.contains(actividad);

      if (!containsActividad) {
        setState(() {
          actividades.add(actividad);
        });

        _showDialog(context, 'Resultado',
            'La actividad se agregó exitosamente.', 'Aceptar');
      } else {
        _showDialog(context, 'Error',
            'No se puede agregar una actividad economica repetida.', 'Aceptar');
      }
    } else {
      _showDialog(
          context,
          'Error',
          'No se ha encontrado la actividad economica asociada a ese codigo.',
          'Aceptar');
    }
  }
}
