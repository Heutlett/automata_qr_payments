import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/ubicacion.dart';
import 'package:flutter_app/utils/utils.dart';

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

  String confirmButtonText = "Crear cuenta";

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

  List<Canton> cantones = [];
  List<Distrito> distritos = [];
  List<Barrio> barrios = [];

  Provincia? selectedProvincia;
  Canton? selectedCanton;
  Distrito? selectedDistrito;
  Barrio? selectedBarrio;

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

  late FocusNode _cedulaTipoFocusNode;
  late FocusNode _cedulaNumeroFocusNode;
  late FocusNode _idExtranjeroFocusNode;
  late FocusNode _nombreFocusNode;
  late FocusNode _nombreComercialFocusNode;
  late FocusNode _tipoCuentaFocusNode;
  late FocusNode _telCodigoPaisFocusNode;
  late FocusNode _telNumeroFocusNode;
  late FocusNode _faxCodigoPaisFocusNode;
  late FocusNode _faxNumeroFocusNode;
  late FocusNode _correoFocusNode;
  late FocusNode _ubicacionProvinciaFocusNode;
  late FocusNode _ubicacionCantonFocusNode;
  late FocusNode _ubicacionDistritoFocusNode;
  late FocusNode _ubicacionBarrioFocusNode;
  late FocusNode _ubicacionSenasFocusNode;
  late FocusNode _ubicacionSenasExtranjeroFocusNode;
  late FocusNode _codigoActividadFocusNode;

  @override
  void initState() {
    super.initState();
    _cedulaTipoFocusNode = FocusNode();
    _cedulaNumeroFocusNode = FocusNode();
    _idExtranjeroFocusNode = FocusNode();
    _nombreFocusNode = FocusNode();
    _nombreComercialFocusNode = FocusNode();
    _tipoCuentaFocusNode = FocusNode();
    _telCodigoPaisFocusNode = FocusNode();
    _telNumeroFocusNode = FocusNode();
    _faxCodigoPaisFocusNode = FocusNode();
    _faxNumeroFocusNode = FocusNode();
    _correoFocusNode = FocusNode();
    _ubicacionProvinciaFocusNode = FocusNode();
    _ubicacionCantonFocusNode = FocusNode();
    _ubicacionDistritoFocusNode = FocusNode();
    _ubicacionBarrioFocusNode = FocusNode();
    _ubicacionSenasFocusNode = FocusNode();
    _ubicacionSenasExtranjeroFocusNode = FocusNode();
    _codigoActividadFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _cedulaNumeroController.dispose();
    _idExtranjeroController.dispose();
    _nombreController.dispose();
    _nombreComercialController.dispose();
    _tipoCuentaFocusNode.dispose();
    _telCodigoPaisController.dispose();
    _telNumeroController.dispose();
    _faxCodigoPaisController.dispose();
    _faxNumeroController.dispose();
    _correoController.dispose();
    _ubicacionSenasController.dispose();
    _ubicacionSenasExtranjeroController.dispose();
    _codigoActividadController.dispose();

    _cedulaTipoFocusNode.dispose();
    _cedulaNumeroFocusNode.dispose();
    _idExtranjeroFocusNode.dispose();
    _nombreFocusNode.dispose();
    _nombreComercialFocusNode.dispose();
    _telCodigoPaisFocusNode.dispose();
    _telNumeroFocusNode.dispose();
    _faxCodigoPaisFocusNode.dispose();
    _faxNumeroFocusNode.dispose();
    _correoFocusNode.dispose();
    _ubicacionProvinciaFocusNode.dispose();
    _ubicacionCantonFocusNode.dispose();
    _ubicacionDistritoFocusNode.dispose();
    _ubicacionBarrioFocusNode.dispose();
    _ubicacionSenasFocusNode.dispose();
    _ubicacionSenasExtranjeroFocusNode.dispose();
    _codigoActividadFocusNode.dispose();

    super.dispose();
  }

  void _focusNextField(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar cuenta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: WillPopScope(
            onWillPop: () async {
              // Mostrar AlertDialog cuando se intenta ir hacia atrás o salir de la aplicación
              bool shouldExit = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¿Estás seguro?'),
                    content: const Text(
                        'Si sales ahora, perderás el progreso del formulario.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(false); // Permanecer en la pantalla actual
                        },
                      ),
                      TextButton(
                        child: const Text('Salir'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(true); // Salir de la pantalla actual
                        },
                      ),
                    ],
                  );
                },
              );

              return shouldExit;
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 232, 232, 232),
                        border: Border.all(color: Colors.black)),
                    child: Column(
                      children: [
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Identificacion',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                focusNode: _cedulaTipoFocusNode,
                                value: _cedulaTipo,
                                decoration: const InputDecoration(
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
                                    _focusNextField(
                                        context,
                                        _cedulaTipoFocusNode,
                                        _cedulaNumeroFocusNode);
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
                                focusNode: _cedulaNumeroFocusNode,
                                controller: _cedulaNumeroController,
                                onEditingComplete: () {
                                  _focusNextField(context,
                                      _cedulaNumeroFocusNode, _nombreFocusNode);
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Número de cédula'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Este campo es obligatorio.';
                                  }
                                  return null;
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: false),
                              ),
                              TextFormField(
                                focusNode: _idExtranjeroFocusNode,
                                controller: _idExtranjeroController,
                                onEditingComplete: () {
                                  _focusNextField(context,
                                      _idExtranjeroFocusNode, _nombreFocusNode);
                                },
                                decoration: const InputDecoration(
                                    labelText: 'ID extranjero'),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: false),
                              ),
                              TextFormField(
                                focusNode: _nombreFocusNode,
                                controller: _nombreController,
                                onEditingComplete: () {
                                  _focusNextField(context, _nombreFocusNode,
                                      _nombreComercialFocusNode);
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Nombre'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Este campo es obligatorio.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                              ),
                              TextFormField(
                                focusNode: _nombreComercialFocusNode,
                                controller: _nombreComercialController,
                                onEditingComplete: () {
                                  _focusNextField(
                                      context,
                                      _nombreComercialFocusNode,
                                      _tipoCuentaFocusNode);
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Nombre comercial'),
                                keyboardType: TextInputType.name,
                              ),
                              DropdownButtonFormField<String>(
                                focusNode: _tipoCuentaFocusNode,
                                value: _tipoCuenta,
                                decoration: const InputDecoration(
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
                                  _focusNextField(context, _tipoCuentaFocusNode,
                                      _telCodigoPaisFocusNode);
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
                        const SizedBox(height: 16.0),
                        Container(
                            padding: const EdgeInsets.all(8),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Teléfono',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          focusNode: _telCodigoPaisFocusNode,
                                          controller: _telCodigoPaisController,
                                          onEditingComplete: () {
                                            _focusNextField(
                                                context,
                                                _telCodigoPaisFocusNode,
                                                _telNumeroFocusNode);
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Código de país'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Este campo es obligatorio.';
                                            }
                                            return null;
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: false),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          focusNode: _telNumeroFocusNode,
                                          controller: _telNumeroController,
                                          onEditingComplete: () {
                                            _focusNextField(
                                                context,
                                                _telNumeroFocusNode,
                                                _faxCodigoPaisFocusNode);
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Número de télefono'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Este campo es obligatorio.';
                                            }
                                            return null;
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: false),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Text(
                                    'Fax',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          focusNode: _faxCodigoPaisFocusNode,
                                          controller: _faxCodigoPaisController,
                                          onEditingComplete: () {
                                            _focusNextField(
                                                context,
                                                _faxCodigoPaisFocusNode,
                                                _faxNumeroFocusNode);
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Código de país'),
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: false),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          focusNode: _faxNumeroFocusNode,
                                          controller: _faxNumeroController,
                                          onEditingComplete: () {
                                            _focusNextField(
                                                context,
                                                _faxNumeroFocusNode,
                                                _correoFocusNode);
                                          },
                                          decoration: const InputDecoration(
                                              labelText: 'Número de fax'),
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: false),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Text(
                                    'Correo electrónico',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    focusNode: _correoFocusNode,
                                    controller: _correoController,
                                    onEditingComplete: () {
                                      _focusNextField(context, _correoFocusNode,
                                          _ubicacionProvinciaFocusNode);
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Correo electrónico',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Este campo es obligatorio.';
                                      }

                                      // Expresión regular para validar la estructura del correo electrónico
                                      RegExp regex = RegExp(
                                        r'^\s*(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\[\]\.,;:\s@\"]+\.)+[^<>()\[\]\.,;:\s@\"]{0,})\s*$',
                                      );

                                      if (!regex.hasMatch(value)) {
                                        return 'Ingrese un correo electrónico válido.';
                                      }

                                      return null;
                                    },
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ])),
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ubicación',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DropdownButtonFormField<Provincia>(
                                focusNode: _ubicacionProvinciaFocusNode,
                                value: selectedProvincia,
                                items: provincias.map((province) {
                                  return DropdownMenuItem<Provincia>(
                                    value: province,
                                    child: Text(province.nombre),
                                  );
                                }).toList(),
                                onChanged: (province) {
                                  setState(() {
                                    selectedProvincia = province;
                                    selectedCanton = null;
                                    selectedDistrito = null;
                                    selectedBarrio = null;
                                    cantones =
                                        []; // Reinicia la lista de cantones
                                    distritos =
                                        []; // Reinicia la lista de distritos
                                    barrios =
                                        []; // Reinicia la lista de barrios
                                    // Simula la carga de los cantones para la provincia seleccionada
                                    loadCantones(context);
                                  });
                                  _focusNextField(
                                      context,
                                      _ubicacionProvinciaFocusNode,
                                      _ubicacionCantonFocusNode);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Provincia',
                                ),
                              ),
                              DropdownButtonFormField<Canton>(
                                focusNode: _ubicacionCantonFocusNode,
                                value: selectedCanton,
                                items: cantones.map((canton) {
                                  return DropdownMenuItem<Canton>(
                                    value: canton,
                                    child: Text(canton.nombre),
                                  );
                                }).toList(),
                                onChanged: (canton) {
                                  setState(() {
                                    selectedCanton = canton;
                                    selectedDistrito = null;
                                    selectedBarrio = null;
                                    distritos =
                                        []; // Reinicia la lista de distritos
                                    barrios =
                                        []; // Reinicia la lista de barrios
                                    // Simula la carga de los distritos para el cantón seleccionado
                                    loadDistritos(context);
                                  });
                                  _focusNextField(
                                      context,
                                      _ubicacionCantonFocusNode,
                                      _ubicacionDistritoFocusNode);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Cantón',
                                ),
                              ),
                              DropdownButtonFormField<Distrito>(
                                focusNode: _ubicacionDistritoFocusNode,
                                value: selectedDistrito,
                                items: distritos.map((district) {
                                  return DropdownMenuItem<Distrito>(
                                    value: district,
                                    child: Text(district.nombre),
                                  );
                                }).toList(),
                                onChanged: (district) {
                                  setState(() {
                                    selectedDistrito = district;
                                    selectedBarrio = null;
                                    barrios =
                                        []; // Reinicia la lista de barrios
                                    // Simula la carga de los barrios para el distrito seleccionado
                                    loadBarrios(context);
                                  });
                                  _focusNextField(
                                      context,
                                      _ubicacionDistritoFocusNode,
                                      _ubicacionBarrioFocusNode);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Distrito',
                                ),
                              ),
                              DropdownButtonFormField<Barrio>(
                                focusNode: _ubicacionBarrioFocusNode,
                                value: selectedBarrio,
                                items: barrios.map((barrio) {
                                  return DropdownMenuItem<Barrio>(
                                    value: barrio,
                                    child: Text(barrio.nombre),
                                  );
                                }).toList(),
                                onChanged: (barrio) {
                                  setState(() {
                                    selectedBarrio = barrio;
                                  });
                                  _focusNextField(
                                      context,
                                      _ubicacionBarrioFocusNode,
                                      _ubicacionSenasFocusNode);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Barrio',
                                ),
                              ),
                              TextFormField(
                                focusNode: _ubicacionSenasFocusNode,
                                controller: _ubicacionSenasController,
                                decoration: const InputDecoration(
                                    labelText: 'Otras señas'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Este campo es obligatorio.';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                focusNode: _ubicacionSenasExtranjeroFocusNode,
                                controller: _ubicacionSenasExtranjeroController,
                                decoration: const InputDecoration(
                                    labelText: 'Otras señas (extranjero)'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Actividades economicas',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                              _codigoActividadController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            labelText: 'Codigo de actividad',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            addActivity(context);
                                            _codigoActividadController
                                                .clear(); // Limpiar el TextFormField
                                            FocusScope.of(context)
                                                .unfocus(); // Ocultar el teclado
                                          },
                                          child:
                                              const Text("Agregar actividad"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  actividades.isEmpty
                                      ? const SizedBox(width: 16.0)
                                      : Column(
                                          children: actividades.map(
                                            (act) {
                                              return Card(
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
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16.0),
                                                        Expanded(
                                                          flex: 1,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                actividades
                                                                    .remove(
                                                                        act);
                                                              });
                                                            },
                                                            child: const Text(
                                                                "Eliminar"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      act.nombre,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm(context, '');
                              } else {
                                showAlertDialog(
                                    context,
                                    "Error",
                                    "El formulario se encuentra incompleto o algún campo es incorrecto.",
                                    "Corregir");
                              }
                            },
                            child: Text(confirmButtonText),
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
      ),
    );
  }

  void _submitForm(BuildContext context, String accountId) async {
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

    if (selectedProvincia == null ||
        selectedCanton == null ||
        selectedDistrito == null ||
        selectedBarrio == null) {
      showAlertDialog(
          context,
          'Error',
          'Todos los campos de ubicación son requeridos, por favor agregue TODOS los campos de ubicación.',
          'Aceptar');
      return;
    }

    String codigoUbicacion = selectedProvincia!.id.toString() +
        selectedCanton!.id.toString().padLeft(2, '0') +
        selectedDistrito!.id.toString().padLeft(2, '0') +
        selectedBarrio!.id.toString().padLeft(2, '0');

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

    var response = await postCreateAccount(cuenta);

    if (context.mounted) {
      if (response.statusCode == 200) {
        showAlertDialogWithFunction(context, 'Cuenta agregada',
            'La cuenta se agregó exitosamente.', 'Aceptar', () {
          reloadAccounts(context);
        });
      } else {
        showAlertDialog(context, 'Error al agregar cuenta',
            'Ocurrió un error al agregar la cuenta.', 'Aceptar');
      }
    }
  }

  void reloadAccounts(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/home_logged", (Route<dynamic> route) => false);
    Navigator.of(context).pushNamed('/account_management');
  }

  void loadCantones(BuildContext context) async {
    if (selectedProvincia != null) {
      var cantonesResponse = await getCantones(selectedProvincia!.id);
      if (cantonesResponse.success) {
        var cantonesList = cantonesResponse.data;
        if (cantonesList != null) {
          setState(() {
            cantones = cantonesList.map((data) {
              return Canton(
                id: data['canton'],
                nombre: data['nombreCanton'].toUpperCase(),
              );
            }).toList();
          });
        }
      } else {
        if (context.mounted) {
          showAlertDialog(context, 'Error',
              'No se han podido obtener los cantones.', 'Aceptar');
        }
      }
    } else {
      showAlertDialog(
          context, 'Error', 'No se ha seleccionado una provincia.', 'Aceptar');
    }
  }

  void loadDistritos(BuildContext context) async {
    if (selectedCanton != null) {
      var distritosResponse =
          await getDistritos(selectedProvincia!.id, selectedCanton!.id);
      if (distritosResponse.success) {
        var distritosList = distritosResponse.data;
        if (distritosList != null) {
          setState(() {
            distritos = distritosList.map((data) {
              return Distrito(
                id: data['distrito'],
                nombre: data['nombreDistrito'].toUpperCase(),
              );
            }).toList();
          });
        }
      } else {
        if (context.mounted) {
          showAlertDialog(context, 'Error',
              'No se han podido obtener los distritos.', 'Aceptar');
        }
      }
    } else {
      showAlertDialog(
          context, 'Error', 'No se ha seleccionado un cantón.', 'Aceptar');
    }
  }

  void loadBarrios(BuildContext context) async {
    if (selectedDistrito != null) {
      var barriosResponse = await getBarrios(
          selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);
      if (barriosResponse.success) {
        var barriosList = barriosResponse.data;
        if (barriosList != null) {
          setState(() {
            barrios = barriosList.map((data) {
              return Barrio(
                id: data['barrio'],
                nombre: data['nombreBarrio'].toUpperCase(),
              );
            }).toList();
          });
        }
      } else {
        if (context.mounted) {
          showAlertDialog(context, 'Error',
              'No se han podido obtener los barrios.', 'Aceptar');
        }
      }
    } else {
      showAlertDialog(
          context, 'Error', 'No se ha seleccionado un distrito.', 'Aceptar');
    }
  }

  void addActivity(BuildContext context) async {
    if (_codigoActividadController.text.isEmpty) {
      showAlertDialog(
          context,
          'Error',
          'El campo Codigo de actividad está vacío, por favor ingresar un codigo de actividad',
          'Aceptar');
    } else {
      Actividad? actividad =
          await getActividadByCode(int.parse(_codigoActividadController.text));

      if (context.mounted) {
        if (actividad != null) {
          bool containsActividad = actividades.contains(actividad);

          if (!containsActividad) {
            setState(() {
              actividades.add(actividad);
            });

            showAlertDialog(context, 'Resultado',
                'La actividad se agregó exitosamente.', 'Aceptar');
          } else {
            showAlertDialog(
                context,
                'Error',
                'No se puede agregar una actividad economica repetida.',
                'Aceptar');
          }
        } else {
          showAlertDialog(
              context,
              'Error',
              'No se ha encontrado la actividad economica asociada a ese codigo.',
              'Aceptar');
        }
      }
    }
  }
}
