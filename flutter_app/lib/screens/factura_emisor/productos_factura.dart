import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

import '../../models/producto.dart';

class ProductosForm extends StatefulWidget {
  ProductosForm({
    super.key,
  });

  @override
  State<ProductosForm> createState() => _ProductosFormState();
}

class _ProductosFormState extends State<ProductosForm> {
  String? _selectedOptionProduct;
  String? _selectedOptionUnidadMedida;

  final List<String> _options = [
    'Productos de la agricultura, silvicultura y pesca',
    'Minerales; electricidad, gas y agua',
    'Productos alimenticios, bebidas y tabaco',
    'Bienes transportables.'
  ];

  final List<Producto> _products = [];

  final List<String> _unidades_medida = ['Al', 'Alc', 'Cm', 'I', 'Os', 'Sp'];

  final _cantidadController = TextEditingController();
  final _detalleController = TextEditingController();
  final _precioUnitarioController = TextEditingController();
  final _descuentoController = TextEditingController();
  final _montoTotalController = TextEditingController();

  double _cantidad = 1;

  void _incrementQuantity() {
    setState(() {
      _cantidad++;
      _cantidadController.text = _cantidad.toString();
    });
  }

  void _decrementQuantity() {
    if (_cantidad > 1) {
      setState(() {
        _cantidad--;
        _cantidadController.text = _cantidad.toString();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cantidadController.dispose();
    _precioUnitarioController.dispose();
    _montoTotalController.dispose();
    _descuentoController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cantidadController.text = _cantidad.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                const MyText(
                  text: "Detalle de productos y servicios",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      const MyText(
                        text: 'Agregar producto o servicio',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: _selectedOptionProduct,
                        decoration: const InputDecoration(
                          labelText: 'Seleccionar producto o servicio',
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedOptionProduct = newValue;
                          });
                        },
                        items: _options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(
                              text: 'Cantidad:',
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  iconSize: 45,
                                  color: Colors.red,
                                  onPressed: _decrementQuantity,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 40,
                                  child: Center(
                                    child: TextFormField(
                                      controller: _cantidadController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Este campo es obligatorio.';
                                        }
                                        return null;
                                      },
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  color: Colors.green,
                                  iconSize: 45,
                                  onPressed: _incrementQuantity,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyText(text: 'Unidad de medida:'),
                            DropdownButton<String>(
                              value: _selectedOptionUnidadMedida,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedOptionUnidadMedida = newValue;
                                });
                              },
                              items: _unidades_medida
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                      TextFormField(
                        controller: _detalleController,
                        decoration: const InputDecoration(labelText: 'Detalle'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _precioUnitarioController,
                        decoration:
                            const InputDecoration(labelText: 'Precio unitario'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _descuentoController,
                        decoration:
                            const InputDecoration(labelText: 'Descuento'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _montoTotalController,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Monto total'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedOptionProduct != null &&
                            _selectedOptionUnidadMedida != null &&
                            _detalleController.text != "") {
                          _products.add(Producto(
                              nombre: _selectedOptionProduct!,
                              cantidad: 0.0,
                              unidadMedida: _selectedOptionUnidadMedida!,
                              detalle: _detalleController.text,
                              precioUnitario: 0.0,
                              descuento: 0.0,
                              montoTotal: 0.0));
                        }
                      });
                    },
                    child: const Text("Agregar")),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: _products.isNotEmpty
                      ? Column(
                          children: [
                            const MyText(
                              text: "Detalle de productos y servicios",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: _products.map(
                                (prod) {
                                  return Column(
                                    children: [
                                      Card(
                                        color: Colors.blueGrey[100],
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                text: prod.nombre,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const MyText(
                                                                text:
                                                                    "Cantidad:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.cantidad.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const MyText(
                                                                text:
                                                                    "Unidad de medida:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.unidadMedida.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              MyText(
                                                                text:
                                                                    "Detalle:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.detalle.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              MyText(
                                                                text:
                                                                    "Precio unitario:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.precioUnitario.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              MyText(
                                                                text:
                                                                    "Descuento:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.descuento.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                              thickness: 1),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              MyText(
                                                                text:
                                                                    "Monto total:",
                                                                fontSize: 16,
                                                              ),
                                                              MyText(
                                                                text:
                                                                    "${prod.montoTotal.toString()}",
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15)
                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: const Column(
                            children: [
                              MyText(
                                text: "Detalle de productos y servicios",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 15),
                              MyText(
                                text: 'No ha agregado productos o servicios',
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
