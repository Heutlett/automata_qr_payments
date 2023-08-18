import 'package:flutter/material.dart';
import 'package:flutter_app/models/factura.dart';
import 'package:flutter_app/screens/account/accounts_form.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/factura_emisor/productos_factura.dart';

import '../../models/producto.dart';
import '../widgets/general/my_text.dart';

class CreateFactura extends StatefulWidget {
  const CreateFactura({super.key});

  @override
  State<CreateFactura> createState() => _CreateFacturaState();
}

class _CreateFacturaState extends State<CreateFactura> {
  int? _selectedIdMoneda = 1;
  int? _selectedMedioPago = 1;
  int? _selectedCondicionVenta = 1;

  final Map<int, String> _tiposMoneda = {
    1: 'Colones',
    2: 'Dolares',
  };

  final Map<int, String> _mediosPago = {
    1: 'Efectivo',
    2: 'Tarjeta',
    3: 'Cheque',
    4: 'Transferencia deposito',
    5: 'Recaudado terceros',
    99: 'Otros',
  };

  final Map<int, String> _condicionesVenta = {
    1: 'Contado',
    2: 'Credito',
    3: 'Consignación',
    4: 'Apartado',
    5: 'Arrendamiento opción compra',
    6: 'Arrendamiento función financiera',
    7: 'Cobro a favor tercero',
    8: 'Servicios estado crédito',
    9: 'Pago servicio estado',
    99: 'Otros',
  };

  final List<Producto> productos = [];

  final _descripcionController = TextEditingController();

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Account> account =
        ModalRoute.of(context)?.settings.arguments as List<Account>;
    final Account accountEmisor = account[0];
    final Account accountReceptor = account[1];

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
            ProductosForm(products: productos),
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
                            items: _tiposMoneda.entries.map((entry) {
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
                            items: _mediosPago.entries.map((entry) {
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
                            items: _condicionesVenta.entries.map((entry) {
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

  void _showFacturaScreen(BuildContext context, Account accountEmisor,
      Account accountReceptor, List<Producto> productos, String descripcion) {
    Factura factura = Factura(
      emisor: accountEmisor,
      receptor: accountReceptor,
      productos: productos,
      idMoneda: _selectedIdMoneda!,
      descripcion: descripcion,
      medioPago: _selectedMedioPago!,
      condicionVenta: _selectedCondicionVenta!,
    );

    Navigator.of(context).pushNamed("/show_factura_json", arguments: factura);
  }
}
