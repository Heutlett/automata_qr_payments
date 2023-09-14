import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/ubicacion.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = createAccountRouteName;

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final List<Actividad> actividades = [];
  final List<Actividad> actividadesSearchName = [];
  List<Actividad> activityList = [];

  String? _cedulaTipo;
  String? _tipoCuenta;

  UbicacionService ubicacionService = UbicacionService();

  List<Provincia> provincias = [];
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
  final _nombreActividadController = TextEditingController();

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
    loadPronvincias();
    loadActivities();
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
    _nombreActividadController.dispose();

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

  void loadPronvincias() async {
    List<Provincia> fetchedProvincias = await ubicacionService.getProvincias();
    setState(() {
      provincias = fetchedProvincias;
    });
  }

  void loadActivities() async {
    List<Actividad> fetchedActivityList = await Actividad.cargarActividades();
    setState(() {
      activityList = fetchedActivityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar cuenta'),
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
                                      focusNode: _cedulaTipoFocusNode,
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
                                        _focusNextField(
                                          context,
                                          _cedulaNumeroFocusNode,
                                          _nombreFocusNode,
                                        );
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'Número de cédula'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Este campo es obligatorio.';
                                        }
                                        if (!isNumeric(value)) {
                                          return 'Este campo debe ser numerico.';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      focusNode: _idExtranjeroFocusNode,
                                      controller: _idExtranjeroController,
                                      onEditingComplete: () {
                                        _focusNextField(
                                            context,
                                            _idExtranjeroFocusNode,
                                            _nombreFocusNode);
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'ID extranjero'),
                                    ),
                                    TextFormField(
                                      focusNode: _nombreFocusNode,
                                      controller: _nombreController,
                                      onEditingComplete: () {
                                        _focusNextField(
                                            context,
                                            _nombreFocusNode,
                                            _nombreComercialFocusNode);
                                      },
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
                                        _focusNextField(
                                            context,
                                            _tipoCuentaFocusNode,
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
                                                focusNode:
                                                    _telCodigoPaisFocusNode,
                                                controller:
                                                    _telCodigoPaisController,
                                                onEditingComplete: () {
                                                  _focusNextField(
                                                      context,
                                                      _telCodigoPaisFocusNode,
                                                      _telNumeroFocusNode);
                                                },
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
                                                focusNode: _telNumeroFocusNode,
                                                controller:
                                                    _telNumeroController,
                                                onEditingComplete: () {
                                                  _focusNextField(
                                                      context,
                                                      _telNumeroFocusNode,
                                                      _faxCodigoPaisFocusNode);
                                                },
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
                                                focusNode:
                                                    _faxCodigoPaisFocusNode,
                                                controller:
                                                    _faxCodigoPaisController,
                                                onEditingComplete: () {
                                                  _focusNextField(
                                                      context,
                                                      _faxCodigoPaisFocusNode,
                                                      _faxNumeroFocusNode);
                                                },
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
                                                focusNode: _faxNumeroFocusNode,
                                                controller:
                                                    _faxNumeroController,
                                                onEditingComplete: () {
                                                  _focusNextField(
                                                      context,
                                                      _faxNumeroFocusNode,
                                                      _correoFocusNode);
                                                },
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
                                          focusNode: _correoFocusNode,
                                          controller: _correoController,
                                          onEditingComplete: () {
                                            _focusNextField(
                                              context,
                                              _correoFocusNode,
                                              _ubicacionProvinciaFocusNode,
                                            );
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Correo electrónico',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Este campo es obligatorio.';
                                            }

                                            if (!emailRegExp.hasMatch(value)) {
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
                                      focusNode:
                                          _ubicacionSenasExtranjeroFocusNode,
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
                                                        addActivity(context);
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
                                                            searchActivityByName(
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
                                      _submitForm(context, providerManager);
                                    } else {
                                      showAlertDialog(
                                          context,
                                          "Error",
                                          "El formulario se encuentra incompleto o algún campo es incorrecto.",
                                          "Corregir");
                                    }
                                  },
                                  child: const Text("Crear cuenta"),
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

  void setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  void _submitForm(
      BuildContext context, ProviderManager providerManager) async {
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

    setLoadingTrue();
    var response = await postCreateAccount(cuenta);
    setLoadingFalse();

    if (response.statusCode == 200) {
      List<Account> accounts = await mapAccountListResponse(response);

      if (context.mounted) {
        showAlertDialogWithFunction(
          context,
          'Cuenta agregada',
          'La cuenta se agregó exitosamente.',
          'Aceptar',
          () {
            reloadAccounts(context, providerManager, accounts);
          },
        );
      }
    } else {
      if (context.mounted) {
        showAlertDialog(
          context,
          'Error al agregar cuenta',
          'Ocurrió un error al agregar la cuenta.',
          'Aceptar',
        );
      }
    }
  }

  Future<void> _loadAccounts(
      ProviderManager providerManager, List<Account> accounts) async {
    providerManager.setMyAccounts(accounts);
  }

  void reloadAccounts(BuildContext context, ProviderManager providerManager,
      List<Account> accounts) async {
    _loadAccounts(providerManager, accounts);
    Navigator.of(context).pushNamedAndRemoveUntil(
        homeLoggedRouteName, (Route<dynamic> route) => false);
    Navigator.of(context).pushNamed(accountManagementRouteName);
  }

  void loadCantones(BuildContext context) async {
    if (selectedProvincia != null) {
      var cantonesList =
          await ubicacionService.getCantonesByProvincia(selectedProvincia!.id);

      setState(() {
        cantones = cantonesList.map((data) {
          return Canton(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      });
    }
  }

  void loadDistritos(BuildContext context) async {
    if (selectedCanton != null) {
      var distritosList = await ubicacionService.getDistritosByCanton(
          selectedProvincia!.id, selectedCanton!.id);

      setState(() {
        distritos = distritosList.map((data) {
          return Distrito(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      });
    }
  }

  void loadBarrios(BuildContext context) async {
    if (selectedDistrito != null) {
      var barriosList = await ubicacionService.getBarriosByDistrito(
          selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);

      setState(() {
        barrios = barriosList.map((data) {
          return Barrio(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      });
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
      String activityCode = _codigoActividadController.text;

      Actividad activity = activityList.firstWhere(
        (actividad) => actividad.codigoActividad == activityCode,
        orElse: () => Actividad.nullActivity,
      );

      if (context.mounted) {
        if (activity != Actividad.nullActivity) {
          bool containsActividad = actividades.contains(activity);

          if (!containsActividad) {
            actividades.add(activity);
            actividadesSearchName.remove(activity);

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

  void searchActivityByName(BuildContext context) async {
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
