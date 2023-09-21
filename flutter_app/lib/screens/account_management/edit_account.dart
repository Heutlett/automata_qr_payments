import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/models/ubicacion.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  static const String routeName = editAccountRouteName;

  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool _isInitialized = false;

  final List<Actividad> actividades = [];
  final List<Actividad> actividadesSearchName = [];
  List<Actividad> activityList = [];

  String? _cedulaTipo;
  String? _tipoCuenta;

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
  final _nombreActividadController = TextEditingController();

  UbicacionService ubicacionService = UbicacionService();

  List<Provincia> provincias = [];

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

    _loadPronvincias();
    _loadActivities();
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
    _nombreActividadController.dispose();
    super.dispose();
  }

  void _loadUbicacion(Account account, ProviderManager providerManager) async {
    var ubicacion =
        await ubicacionService.getUbicacion(account.ubicacionCodigo);
    if (ubicacion != null) {
      setState(() {
        selectedProvincia = provincias
            .firstWhere((provincia) => provincia.id == ubicacion.provincia.id);

        selectedCanton = providerManager.cantonesSelectedEditAccount!
            .firstWhere((canton) => canton.id == ubicacion.canton.id);

        selectedDistrito = providerManager.distritosSelectedEditAccount!
            .firstWhere((distrito) => distrito.id == ubicacion.distrito.id);

        selectedBarrio = providerManager.barriosSelectedEditAccount!
            .firstWhere((barrio) => barrio.id == ubicacion.barrio.id);
      });
    }
  }

  void _loadPronvincias() async {
    List<Provincia> fetchedProvincias = await ubicacionService.getProvincias();
    setState(() {
      provincias = fetchedProvincias;
    });
  }

  void _loadActivities() async {
    List<Actividad> fetchedActivityList = await Actividad.cargarActividades();
    setState(() {
      activityList = fetchedActivityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    if (!_isInitialized) {
      Account account = providerManager.selectedEditAccount!;

      _loadUbicacion(account, providerManager);

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
        _initActivities(context, account.actividades![i].codigoActividad);
      }

      _isInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar cuenta'),
      ),
      body: provincias.isEmpty | activityList.isEmpty | isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicador de carga
          : SingleChildScrollView(
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
                                Navigator.of(context).pop(
                                    false); // Permanecer en la pantalla actual
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
                                      value: _cedulaTipo,
                                      decoration: const InputDecoration(
                                        labelText: 'Tipo de cédula',
                                      ),
                                      items: cedulaTipos
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
                                    ),
                                    TextFormField(
                                      controller: _idExtranjeroController,
                                      decoration: const InputDecoration(
                                          labelText: 'ID extranjero'),
                                    ),
                                    TextFormField(
                                      controller: _nombreController,
                                      decoration: const InputDecoration(
                                          labelText: 'Nombre'),
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
                                      items: tiposCuenta
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                controller:
                                                    _telCodigoPaisController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Código de país'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Este campo es obligatorio.';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                controller:
                                                    _telNumeroController,
                                                decoration: const InputDecoration(
                                                    labelText:
                                                        'Número de télefono'),
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
                                                controller:
                                                    _faxCodigoPaisController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Código de país'),
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            Expanded(
                                              flex: 2,
                                              child: TextFormField(
                                                controller:
                                                    _faxNumeroController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Número de fax'),
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          providerManager
                                              .clearCantonesSelectedEditAccount();
                                          providerManager
                                              .clearDistritosSelectedEditAccount();
                                          providerManager
                                              .clearBarriosSelectedEditAccount();

                                          _loadCantones(
                                              context, providerManager);
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Provincia',
                                      ),
                                    ),
                                    DropdownButtonFormField<Canton>(
                                      value: selectedCanton,
                                      items: providerManager
                                          .cantonesSelectedEditAccount!
                                          .map((canton) {
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
                                          providerManager
                                              .clearDistritosSelectedEditAccount();
                                          providerManager
                                              .clearBarriosSelectedEditAccount();
                                          _loadDistritos(
                                              context, providerManager);
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Cantón',
                                      ),
                                    ),
                                    DropdownButtonFormField<Distrito>(
                                      value: selectedDistrito,
                                      items: providerManager
                                          .distritosSelectedEditAccount!
                                          .map((district) {
                                        return DropdownMenuItem<Distrito>(
                                          value: district,
                                          child: Text(district.nombre),
                                        );
                                      }).toList(),
                                      onChanged: (district) {
                                        setState(() {
                                          selectedDistrito = district;
                                          selectedBarrio = null;
                                          providerManager
                                              .clearBarriosSelectedEditAccount();
                                          _loadBarrios(
                                              context, providerManager);
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Distrito',
                                      ),
                                    ),
                                    DropdownButtonFormField<Barrio>(
                                      value: selectedBarrio,
                                      items: providerManager
                                          .barriosSelectedEditAccount!
                                          .map((neighborhood) {
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
                                      controller:
                                          _ubicacionSenasExtranjeroController,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Otras señas (extranjero)'),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          color: Colors.amber[100],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const MyText(
                                                fontSize: 14,
                                                text:
                                                    'Buscar por código de actividad:',
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _codigoActividadController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Código de actividad',
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16.0),
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        _addActivity(context);
                                                        _codigoActividadController
                                                            .clear(); // Limpiar el TextFormField
                                                        FocusScope.of(context)
                                                            .unfocus(); // Ocultar el teclado
                                                      },
                                                      child: const Text(
                                                          "Agregar actividad"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.green[100],
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const MyText(
                                                    fontSize: 14,
                                                    text:
                                                        'Buscar por nombre de actividad:',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              _nombreActividadController,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Nombre de actividad',
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 16.0),
                                                      MyButton(
                                                          size: const Size(
                                                              80, 20),
                                                          fontSize: 14,
                                                          text: 'Buscar',
                                                          function: () {
                                                            _searchActivityByName(
                                                                context);
                                                            _nombreActividadController
                                                                .clear(); // Limpiar el TextFormField
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(); // Ocultar el teclado
                                                          }),
                                                      const SizedBox(width: 10),
                                                      MyButton(
                                                          size: const Size(
                                                              85, 20),
                                                          fontSize: 14,
                                                          text: 'Limpiar',
                                                          function: () {
                                                            setState(() {
                                                              actividadesSearchName
                                                                  .clear();
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  actividadesSearchName.isEmpty
                                                      ? const SizedBox(
                                                          width: 16.0)
                                                      : Column(
                                                          children:
                                                              actividadesSearchName
                                                                  .map(
                                                            (act) {
                                                              return Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              act.codigoActividad,
                                                                              style: const TextStyle(fontSize: 15),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 16.0),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  actividades.add(act);
                                                                                  actividadesSearchName.remove(act);
                                                                                  showAlertDialog(context, 'Actividad agregada', 'La actividad se agregó correctamente.', 'Aceptar');
                                                                                });
                                                                              },
                                                                              child: const Text("Agregar"),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        act.nombre,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).toList(),
                                                        ),
                                                ])),
                                        const SizedBox(height: 16.0),
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            width: double.infinity,
                                            color: Colors.red[100],
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const MyText(
                                                    text: 'Mis actividades:',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const Divider(thickness: 1),
                                                  actividades.isEmpty
                                                      ? const SizedBox(
                                                          width: 16.0)
                                                      : Column(
                                                          children:
                                                              actividades.map(
                                                            (act) {
                                                              return Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              act.codigoActividad,
                                                                              style: const TextStyle(fontSize: 15),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 16.0),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  actividades.remove(act);
                                                                                });
                                                                              },
                                                                              child: const Text("Eliminar"),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        act.nombre,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).toList(),
                                                        )
                                                ])),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitEditAccountForm(
                                          context,
                                          providerManager
                                              .selectedEditAccount!.id,
                                          providerManager);
                                    } else {
                                      showAlertDialog(
                                        context,
                                        'Error',
                                        'El formulario se encuentra incompleto o algún campo es incorrecto.',
                                        'Corregir',
                                      );
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
            ),
    );
  }

  void _setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  void _submitEditAccountForm(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    final cedulaTipo = _cedulaTipo;
    final cedulaNumero = _cedulaNumeroController.text;
    final idExtranjero = _idExtranjeroController.text;
    final nombre = _nombreController.text.toUpperCase();
    final nombreComercial = _nombreComercialController.text.toUpperCase();
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
      "codigosActividad": actividades.map((act) => act.codigoActividad).toList()
    };

    _setLoadingTrue();
    var response = await putEditAccount(accountId, cuenta);
    _setLoadingFalse();

    if (response.statusCode == 200) {
      _setLoadingTrue();
      List<Account> accounts = await mapAccountListResponse(response);
      _setLoadingFalse();
      if (context.mounted) {
        showAlertDialogWithFunction(
          context,
          'Cuenta editada',
          'La cuenta se editó exitosamente.',
          'Aceptar',
          () {
            providerManager.reloadAccountsInAccountManagement(
                context, accounts);
          },
        );
      }
    } else {
      if (context.mounted) {
        showAlertDialog(
          context,
          'Error al editar cuenta',
          'Ocurrió un error al editar la cuenta.',
          'Aceptar',
        );
      }
    }
  }

  void _initActivities(BuildContext context, String activity) async {
    List<Actividad> listaActividades = await Actividad.cargarActividades();

    Actividad actividad = listaActividades.firstWhere(
      (actividad) => actividad.codigoActividad == activity,
      orElse: () => Actividad.nullActivity,
    );

    setState(() {
      actividades.add(actividad);
    });
  }

  void _addActivity(BuildContext context) async {
    if (_codigoActividadController.text.isEmpty) {
      showAlertDialog(
          context,
          'Error',
          'El campo Codigo de actividad está vacío, por favor ingresar un codigo de actividad',
          'Aceptar');
    } else {
      String activityCode = _codigoActividadController.text;

      Actividad activity = activityList.firstWhere(
        (actividad) => actividad.codigoActividad == activityCode,
        orElse: () => Actividad.nullActivity,
      );

      if (context.mounted) {
        if (activity != Actividad.nullActivity) {
          bool containsActividad = actividades.contains(activity);

          if (!containsActividad) {
            setState(() {
              actividades.add(activity);
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

  void _loadCantones(
      BuildContext context, ProviderManager providerManager) async {
    var cantonesList =
        await ubicacionService.getCantonesByProvincia(selectedProvincia!.id);

    providerManager.setCantonesSelectedEditAccount(cantonesList.map((data) {
      return Canton(
        id: data.id,
        nombre: data.nombre.toUpperCase(),
      );
    }).toList());
  }

  void _loadDistritos(
      BuildContext context, ProviderManager providerManager) async {
    var distritosList = await ubicacionService.getDistritosByCanton(
        selectedProvincia!.id, selectedCanton!.id);

    providerManager.setDistritosSelectedEditAccount(distritosList.map((data) {
      return Distrito(
        id: data.id,
        nombre: data.nombre.toUpperCase(),
      );
    }).toList());
  }

  void _loadBarrios(
      BuildContext context, ProviderManager providerManager) async {
    var barriosList = await ubicacionService.getBarriosByDistrito(
        selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);

    providerManager.setBarriosSelectedEditAccount(barriosList.map((data) {
      return Barrio(
        id: data.id,
        nombre: data.nombre.toUpperCase(),
      );
    }).toList());
  }

  void _searchActivityByName(BuildContext context) async {
    if (_nombreActividadController.text.isEmpty) {
      showAlertDialog(
          context,
          'Error',
          'El campo Codigo de actividad está vacío, por favor ingresar un codigo de actividad',
          'Aceptar');
    } else {
      String activityName = _nombreActividadController.text;

      List<Actividad> foundedActivities = activityList
          .where(
            (actividad) => actividad.nombre
                .toLowerCase()
                .contains(activityName.toLowerCase()),
          )
          .toList();

      if (context.mounted) {
        if (foundedActivities.isNotEmpty) {
          setState(() {
            actividadesSearchName.addAll(foundedActivities);
            for (int i = 0; i < actividades.length; i++) {
              actividadesSearchName.remove(actividades[i]);
            }
          });
        } else {
          showAlertDialog(
              context,
              'Error',
              'No se han encontrado actividades economica asociadas a ese nombre.',
              'Aceptar');
        }
      }
    }
  }
}
