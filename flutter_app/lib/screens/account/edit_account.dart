import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/models/ubicacion.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();

  bool _isInitialized = false;

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
  final _ubicacionSenasController = TextEditingController();
  final _ubicacionSenasExtranjeroController = TextEditingController();

  final _codigoActividadController = TextEditingController();

  // Lista de cantones
  List<Canton> cantones = [];

  // Lista de distritos
  List<Distrito> distritos = [];

  // Lista de barrios
  List<Barrio> barrios = [];

  Provincia? selectedProvincia;
  Canton? selectedCanton;
  Distrito? selectedDistrito;
  Barrio? selectedBarrio;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isInitialized = false;
    });
  }

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

  void loadUbicacion(Account account) async {
    var response = await getUbicacion(account.ubicacionCodigo);

    if (response.success) {
      var ubicacion = response.data;
      if (ubicacion != null) {
        setState(() {
          selectedProvincia = provincias.firstWhere(
              (provincia) => provincia.id == ubicacion.provincia.id);

          selectedCanton =
              cantones.firstWhere((canton) => canton.id == ubicacion.canton.id);

          selectedDistrito = distritos
              .firstWhere((distrito) => distrito.id == ubicacion.distrito.id);

          selectedBarrio =
              barrios.firstWhere((barrio) => barrio.id == ubicacion.barrio.id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    Account account = args[0];

    //Account account = ModalRoute.of(context)?.settings.arguments as Account;

    if (!_isInitialized) {
      cantones = args[1];
      distritos = args[2];
      barrios = args[3];
      loadUbicacion(account);

      _cedulaTipo = account.cedulaTipo;
      _cedulaNumeroController.text = account.cedulaNumero;
      _idExtranjeroController.text = account.idExtranjero;
      _nombreController.text = account.nombre;
      _nombreComercialController.text = account.nombreComercial;
      _tipoCuenta = account.tipo;
      _telCodigoPaisController.text = account.telCodigoPais;
      _telNumeroController.text = account.telNumero;
      _faxCodigoPaisController.text = account.faxCodigoPais;
      _faxNumeroController.text = account.faxNumero;
      _correoController.text = account.correo;
      _ubicacionSenasController.text = account.ubicacionSenas;
      _ubicacionSenasExtranjeroController.text =
          account.ubicacionSenasExtranjero;

      for (int i = 0; i < account.actividades!.length; i++) {
        initActivities(context, account.actividades![i].codigoActividad);
      }

      _isInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cuenta'),
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
                              decoration: const InputDecoration(
                                  labelText: 'Número de cédula'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio.';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            TextFormField(
                              controller: _idExtranjeroController,
                              decoration: const InputDecoration(
                                  labelText: 'ID extranjero'),
                              keyboardType: TextInputType.number,
                            ),
                            TextFormField(
                              controller: _nombreController,
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
                              controller: _nombreComercialController,
                              decoration: const InputDecoration(
                                  labelText: 'Nombre comercial'),
                              keyboardType: TextInputType.name,
                            ),
                            DropdownButtonFormField<String>(
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
                                        controller: _telCodigoPaisController,
                                        decoration: const InputDecoration(
                                            labelText: 'Código de país'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Este campo es obligatorio.';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: _telNumeroController,
                                        decoration: const InputDecoration(
                                            labelText: 'Número de télefono'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Este campo es obligatorio.';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
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
                                        controller: _faxCodigoPaisController,
                                        decoration: const InputDecoration(
                                            labelText: 'Código de país'),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: _faxNumeroController,
                                        decoration: const InputDecoration(
                                            labelText: 'Número de fax'),
                                        keyboardType: TextInputType.number,
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
                                  controller: _correoController,
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
                                  barrios = []; // Reinicia la lista de barrios
                                  // Simula la carga de los cantones para la provincia seleccionada
                                  loadCantones(context);
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Provincia',
                              ),
                            ),
                            DropdownButtonFormField<Canton>(
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
                                  barrios = []; // Reinicia la lista de barrios
                                  // Simula la carga de los distritos para el cantón seleccionado
                                  loadDistritos(context);
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Cantón',
                              ),
                            ),
                            DropdownButtonFormField<Distrito>(
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
                                  barrios = []; // Reinicia la lista de barrios
                                  // Simula la carga de los barrios para el distrito seleccionado
                                  loadBarrios(context);
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Distrito',
                              ),
                            ),
                            DropdownButtonFormField<Barrio>(
                              value: selectedBarrio,
                              items: barrios.map((neighborhood) {
                                return DropdownMenuItem<Barrio>(
                                  value: neighborhood,
                                  child: Text(neighborhood.nombre),
                                );
                              }).toList(),
                              onChanged: (neighborhood) {
                                setState(() {
                                  selectedBarrio = neighborhood;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Barrio',
                              ),
                            ),
                            TextFormField(
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
                                        controller: _codigoActividadController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
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
                                        child: const Text("Agregar actividad"),
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
                                                                  fontSize: 15),
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
                                                                  .remove(act);
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
                              _submitForm(context, account.id);
                            } else {
                              showAlertDialog(
                                  context,
                                  "Error",
                                  "El formulario se encuentra incompleto o algún campo es incorrecto.",
                                  "Corregir");
                            }
                          },
                          child: const Text('Editar cuenta'),
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
      "id": accountId,
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

    var response = await putEditAccount(accountId, cuenta);

    if (context.mounted) {
      if (response.statusCode == 200) {
        showAlertDialogWithFunction(context, 'Cuenta editada',
            'La cuenta se editó exitosamente.', 'Aceptar', () {
          reloadAccounts(context);
        });
      } else {
        showAlertDialog(context, 'Error al editar cuenta',
            'Ocurrió un error al editar la cuenta.', 'Aceptar');
      }
    }
  }

  void reloadAccounts(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/home_logged", (Route<dynamic> route) => false);
    Navigator.of(context).pushNamed('/account_management');
  }

  void initActivities(BuildContext context, String activity) async {
    Actividad? actividad = await getActividadByCode(int.parse(activity));

    setState(() {
      actividades.add(actividad!);
    });
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
}
