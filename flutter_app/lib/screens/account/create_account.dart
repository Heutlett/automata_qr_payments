import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/services/usuario/usuario_service.dart';
import '../../models/actividad.dart';

class AgregarCuentaForm extends StatefulWidget {
  const AgregarCuentaForm({super.key});

  @override
  State<AgregarCuentaForm> createState() => _AgregarCuentaFormState();
}

class _AgregarCuentaFormState extends State<AgregarCuentaForm> {
  final _formKey = GlobalKey<FormState>();

  final List<Actividad> actividades = [];

  String? _cedulaTipo;
  String? _tipoCuenta;

  String? _ubicacionProvincia;
  String? _ubicacionCanton;
  String? _ubicacionDistrito;
  String? _ubicacionBarrio;

  int _idProvincia = 0;
  int _idCanton = 0;
  int _idDistrito = 0;
  int _idBarrio = 0;

  List<Map<String, dynamic>>? _provinciasMap;
  List<Map<String, dynamic>>? _cantonesMap;
  List<Map<String, dynamic>>? _distritosMap;
  List<Map<String, dynamic>>? _barriosMap;

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

  List<String> _provincias = [];
  final List<String> _cantones = [];
  final List<String> _distritos = [];
  final List<String> _barrios = [];

  final _cedulaNumeroController = TextEditingController();
  final _idExtranjeroController = TextEditingController();
  final _nombreController = TextEditingController();
  final _nombreComercialController = TextEditingController();
  final _telCodigoPaisController = TextEditingController();
  final _telNumeroController = TextEditingController();
  final _faxCodigoPaisController = TextEditingController();
  final _faxNumeroController = TextEditingController();
  final _correoController = TextEditingController();
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
    _ubicacionSenasController.dispose();
    _ubicacionSenasExtranjeroController.dispose();
    _codigoActividadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _provinciasMap = ModalRoute.of(context)?.settings.arguments
        as List<Map<String, dynamic>>?;
    _provincias = _provinciasMap!
        .map((mapa) => mapa['nombreProvincia'] as String)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar cuenta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 232, 232),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Identificacion',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                              decoration: InputDecoration(
                                  labelText: 'Número de cédula'),
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
                                  InputDecoration(labelText: 'ID extranjero'),
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
                              decoration: InputDecoration(
                                  labelText: 'Nombre comercial'),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                          padding: EdgeInsets.all(8),
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teléfono',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _telCodigoPaisController,
                                          decoration: InputDecoration(
                                              labelText: 'Código de país'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Este campo es obligatorio.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          controller: _telNumeroController,
                                          decoration: InputDecoration(
                                              labelText: 'Número de télefono'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Este campo es obligatorio.';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Fax',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _faxCodigoPaisController,
                                          decoration: InputDecoration(
                                              labelText: 'Código de país'),
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          controller: _faxNumeroController,
                                          decoration: InputDecoration(
                                              labelText: 'Número de fax'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Correo electrónico',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  controller: _correoController,
                                  decoration: InputDecoration(
                                      labelText: 'Correo electrónico'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Este campo es obligatorio.';
                                    }
                                    return null;
                                  },
                                ),
                              ])),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ubicación',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: _ubicacionProvincia,
                              decoration: InputDecoration(
                                labelText: 'Provincia',
                              ),
                              items: _provincias
                                  .map(
                                    (prov) => DropdownMenuItem(
                                      value: prov,
                                      child: Text(prov),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _ubicacionProvincia = value;
                                  },
                                );
                                showCantones();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio.';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              value: _ubicacionCanton,
                              decoration: InputDecoration(
                                labelText: 'Cantón',
                              ),
                              items: _cantones
                                  .map(
                                    (cant) => DropdownMenuItem(
                                      value: cant,
                                      child: Text(cant),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _ubicacionCanton = value;
                                  },
                                );
                                showDistritos();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio.';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              value: _ubicacionDistrito,
                              decoration: InputDecoration(
                                labelText: 'Distrito',
                              ),
                              items: _distritos
                                  .map(
                                    (dist) => DropdownMenuItem(
                                      value: dist,
                                      child: Text(dist),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _ubicacionDistrito = value;
                                  },
                                );
                                showBarrios();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio.';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              value: _ubicacionBarrio,
                              decoration: InputDecoration(
                                labelText: 'Barrio',
                              ),
                              items: _barrios
                                  .map(
                                    (barr) => DropdownMenuItem(
                                      value: barr,
                                      child: Text(barr),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    _ubicacionBarrio = value;
                                  },
                                );
                              },
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
                                  InputDecoration(labelText: 'Otras señas'),
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
                                  labelText: 'Otras señas (extranjero)'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Actividades economicas',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _codigoActividadController,
                                            keyboardType: TextInputType
                                                .number, // Esto cambiará el tipo de teclado a numérico
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                                labelText:
                                                    'Codigo de actividad'),
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
                                          children: actividades.map(
                                            (act) {
                                              return Container(
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
                                                                        15),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 16.0),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                    "Eliminar"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          act.nombre,
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm(context);
                            } else {
                              _showDialog(
                                  context,
                                  "Error",
                                  "Error, hay campos obligatorios sin llenar",
                                  "Corregir");
                            }
                          },
                          child: Container(
                            child: Text('Agregar cuenta'),
                          ),
                        ),
                      ),
                    ],
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

  void _submitForm(BuildContext context) async {
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
    final ubicacionSenas = _ubicacionSenasController.text;
    final ubicacionSenasExtranjero = _ubicacionSenasExtranjeroController.text;
    final tipo = _tipoCuenta;

    String codigoUbicacion = _idProvincia.toString() +
        _idCanton.toString().padLeft(2, '0') +
        _idDistrito.toString().padLeft(2, '0') +
        _idBarrio.toString().padLeft(2, '0');

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
      "ubicacionCodigo": codigoUbicacion,
      "ubicacionSenas": ubicacionSenas,
      "ubicacionSenasExtranjero": ubicacionSenasExtranjero,
      "tipo": tipo,
      "actividades": actividades.map((act) => act.codigoActividad).toList()
    };

    var response = await postCreateAccount(cuenta, actividades);

    if (response.statusCode == 200) {
      _showDialog(context, 'Cuenta agregada',
          'La cuenta se agregó exitosamente.', 'Aceptar');
      Navigator.of(context).pop();
      Navigator.of(context).pop();
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

  void showCantones() async {
    _idProvincia = _provinciasMap!.firstWhere(
        (prov) => prov['nombreProvincia'] == _ubicacionProvincia)['provincia'];

    var cantonesResponse = await getCantones(_idProvincia);
    if (cantonesResponse.success) {
      var cantonesList = cantonesResponse.data;
      if (cantonesList != null) {
        _cantonesMap = cantonesList;
        _cantones.clear();
        for (var canton in cantonesList) {
          setState(() {
            _cantones.add(canton['nombreCanton']);
            _idCanton = canton['canton'];
          });
        }
      }
    } else {
      _showDialog(context, 'Error', cantonesResponse.message, 'Aceptar');
    }
  }

  void showDistritos() async {
    var distritosResponse = await getDistritos(_idProvincia, _idCanton);
    if (distritosResponse.success) {
      var distritosList = distritosResponse.data;
      if (distritosList != null) {
        _distritosMap = distritosList;
        _distritos.clear();
        for (var distrito in distritosList) {
          setState(() {
            _distritos.add(distrito['nombreDistrito']);
            _idDistrito = distrito['distrito'];
          });
        }
      }
    } else {
      _showDialog(context, 'Error', distritosResponse.message, 'Aceptar');
    }
  }

  void showBarrios() async {
    var barriosResponse =
        await getBarrios(_idProvincia, _idCanton, _idDistrito);
    if (barriosResponse.success) {
      var barriosList = barriosResponse.data;
      if (barriosList != null) {
        _barrios.clear();
        for (var barrio in barriosList) {
          setState(() {
            _barrios.add(barrio['nombreBarrio']);
            _idBarrio = barrio['barrio'];
          });
        }
      }
    } else {
      _showDialog(context, 'Error', barriosResponse.message, 'Aceptar');
    }
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
