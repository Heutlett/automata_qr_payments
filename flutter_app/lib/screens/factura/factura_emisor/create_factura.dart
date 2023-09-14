import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/factura.dart';
import 'package:flutter_app/widgets/account/accounts_form.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/factura/factura_products.dart';
import 'package:flutter_app/utils/utils.dart';

import '../../../models/actividad.dart';
import '../../../models/producto.dart';
import '../../../widgets/general/my_text.dart';

class CreateFacturaScreen extends StatefulWidget {
  static const String routeName = createFacturaRouteName;

  const CreateFacturaScreen({super.key});

  @override
  State<CreateFacturaScreen> createState() => _CreateFacturaScreenState();
}

class _CreateFacturaScreenState extends State<CreateFacturaScreen> {
  int? _selectedIdMoneda = defaultMonedaId;
  int? _selectedMedioPago = defaultMedioPago;
  int? _selectedCondicionVenta = defaultCondicionVenta;

  final List<Producto> productos = [];

  final _descripcionController = TextEditingController();

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> data =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final Account accountEmisor = data[0];
    final Account accountReceptor = data[1];
    final String receptorModelName = data[2];
    final List<double> receptorLocation = data[3];
    final String receptorTimeStamp = data[4];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación de factura emisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountForm(
              titulo: 'Datos emisor',
              account: accountEmisor,
              isEmisor: true,
            ),
            AccountForm(
              titulo: 'Datos receptor',
              account: accountReceptor,
              isEmisor: false,
            ),
            FacturaProductsForm(products: productos),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                      child: MyText(
                        text: 'Campos de factura',
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  text: 'Seleccione el tipo de moneda:',
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          DropdownButtonFormField<int>(
                            value: _selectedIdMoneda,
                            items: tiposMoneda.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value,
                                    style: const TextStyle(fontSize: 15)),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedIdMoneda = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  text: 'Seleccione el medio de pago:',
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          DropdownButtonFormField<int>(
                            value: _selectedMedioPago,
                            items: mediosPago.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value,
                                    style: const TextStyle(fontSize: 15)),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedMedioPago = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                  text: 'Seleccione la condicion de venta:',
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          DropdownButtonFormField<int>(
                            value: _selectedCondicionVenta,
                            items: condicionesVenta.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value,
                                    style: const TextStyle(fontSize: 15)),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedCondicionVenta = newValue;
                              });
                            },
                          ),
                          TextFormField(
                            controller: _descripcionController,
                            decoration:
                                const InputDecoration(labelText: 'Descripción'),
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 180,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    _showFacturaScreen(
                      context,
                      accountEmisor,
                      accountReceptor,
                      productos,
                      _descripcionController.text,
                      receptorModelName,
                      receptorLocation,
                      receptorTimeStamp,
                    );
                  },
                  child: const Text(
                    'Crear factura',
                    style: TextStyle(fontSize: 22),
                  )),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  void _showFacturaScreen(
    BuildContext context,
    Account accountEmisor,
    Account accountReceptor,
    List<Producto> productos,
    String descripcion,
    String receptorModelName,
    List<double> receptorLocation,
    String receptorTimeStamp,
  ) async {
    Actividad? actividad;

    var emisorLocation = await getLocation();
    var emisorModelName = await getDeviceModel();
    var emisorTimeStamp = DateTime.now().toIso8601String();

    if (accountEmisor.actividades != null) {
      for (int i = 0; i < accountEmisor.actividades!.length; i++) {
        if (accountEmisor.actividades![i].selected) {
          actividad = accountEmisor.actividades![i];
        }
      }

      if (actividad != null) {
        Factura factura = Factura(
          codigoActividadEmisor: actividad.codigoActividad,
          dispositivoGenerador: receptorModelName,
          latitudGenerador: receptorLocation[0],
          longitudGenerador: receptorLocation[1],
          timestampGenerador: receptorTimeStamp,
          latitudLector: emisorLocation[0],
          longitudLector: emisorLocation[1],
          dispositivoLector: emisorModelName,
          timestampLector: emisorTimeStamp,
          cuentaEmisorId: accountEmisor.id,
          cuentaReceptorId: accountReceptor.id,
          lineasDetalle: productos,
          codigoMonedaId: _selectedIdMoneda!,
          descripcion: descripcion,
          medioPago: _selectedMedioPago!,
          condicionVenta: _selectedCondicionVenta!,
        );
        if (context.mounted) {
          Navigator.of(context).pushNamed(
            showFacturaRouteName,
            arguments: [
              factura,
            ],
          );
        }
      } else {
        if (context.mounted) {
          showAlertDialog(
            context,
            "Error",
            "No se ha seleccionado la actividad economica del emisor",
            "Aceptar",
          );
        }
      }
    } else {
      if (context.mounted) {
        showAlertDialog(
          context,
          "Error",
          "El emisor no cuenta con actividades economicas",
          "Aceptar",
        );
      }
    }
  }
}
