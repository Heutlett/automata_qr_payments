import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';
import 'package:flutter_app/utils/utils.dart';

import '../../models/producto.dart';

class ProductosForm extends StatefulWidget {
  final List<Producto> products;

  const ProductosForm({super.key, required this.products});

  @override
  State<ProductosForm> createState() => _ProductosFormState();
}

class _ProductosFormState extends State<ProductosForm> {
  String? _selectedOptionUnidadMedida;
  int? _selectedOptionTipoCodigoComercial;
  int? _selectedOptionCabysId;

  int numeroLineaDetalle = 1;

  late List<Producto> products;

  final Map<int, String> _cabysOptions = {
    1: 'Productos de la agricultura, silvicultura y pesca',
    2: 'Minerales; electricidad, gas y agua',
    3: 'Productos alimenticios, bebidas y tabaco',
    4: 'Bienes transportables.'
  };

  final List<String> _unidadesMedida = [
    'Al',
    'Alc',
    'Cm',
    'I',
    'Os',
    'Sp',
  ];

  final Map<int, String> _tiposCodigoComercial = {
    1: 'Código del producto del vendedor',
    2: 'Código del producto del comprador',
    3: 'Código del producto asignado por la industria',
    4: 'Código de uso interno',
    99: 'Otros',
  };

  final _cantidadController = TextEditingController();
  final _detalleController = TextEditingController();
  final _precioUnitarioController = TextEditingController();
  final _descuentoController = TextEditingController();
  final _montoTotalController = TextEditingController();
  final _codigoComercialController = TextEditingController();
  final _unidadMedidaComercialController = TextEditingController();

  int _cantidad = 1;

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
    super.dispose();
    _cantidadController.dispose();
    _precioUnitarioController.dispose();
    _montoTotalController.dispose();
    _descuentoController.dispose();
    _codigoComercialController.dispose();
    _unidadMedidaComercialController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cantidadController.text = _cantidad.toString();
    products = widget.products;
  }

  void updateProductsIndex() {
    setState(() {
      for (int i = 0; i < products.length;) {
        products[i].numeroLinea = i + 1;
      }
      numeroLineaDetalle = products.length + 1;
    });
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
                      DropdownButtonFormField<int>(
                        value: _selectedOptionCabysId,
                        items: _cabysOptions.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value,
                                style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedOptionCabysId = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Seleccionar producto o servicio',
                        ),
                      ),
                      DropdownButtonFormField<int>(
                        value: _selectedOptionTipoCodigoComercial,
                        items: _tiposCodigoComercial.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value,
                                style: const TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedOptionTipoCodigoComercial = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Seleccionar tipo de codigo comercial',
                        ),
                      ),
                      TextFormField(
                        controller: _codigoComercialController,
                        decoration: const InputDecoration(
                            labelText: 'Codigo comercial'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
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
                              items: _unidadesMedida
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
                        controller: _unidadMedidaComercialController,
                        decoration: const InputDecoration(
                            labelText: 'Unidad de medida comercial'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                      ),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedOptionCabysId != null &&
                            _selectedOptionUnidadMedida != null &&
                            _detalleController.text != "") {
                          products.add(
                            Producto(
                              numeroLinea: numeroLineaDetalle,
                              cabysId: _selectedOptionCabysId!, // Arreglar esto
                              tipoCodigoComercial:
                                  _selectedOptionTipoCodigoComercial.toString(),
                              codigoComercial: _codigoComercialController.text,
                              cantidad: int.parse(_cantidadController.text),
                              unidadMedida: _selectedOptionUnidadMedida!,
                              unidadMedidaComercial:
                                  _unidadMedidaComercialController.text,
                              detalle: _detalleController.text,
                              precioUnitario:
                                  int.parse(_precioUnitarioController.text),
                              descuento: int.parse(_descuentoController.text),
                            ),
                          );
                          numeroLineaDetalle++;
                          _selectedOptionCabysId = null;
                          _selectedOptionTipoCodigoComercial = null;
                          _selectedOptionUnidadMedida = null;
                          _codigoComercialController.clear();
                          _cantidad = 1;
                          _cantidadController.text = '1';
                          _unidadMedidaComercialController.clear();
                          _selectedOptionUnidadMedida = null;
                          _detalleController.clear();
                          _precioUnitarioController.clear();
                          _descuentoController.clear();
                        } else {
                          showAlertDialog(
                              context,
                              "Error",
                              "No ha completado todos los campos requeridos para agregar un producto o servicio",
                              "Aceptar");
                        }
                      });
                    },
                    child: const Text("Agregar")),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: products.isNotEmpty
                      ? Column(
                          children: [
                            const MyText(
                              text: "Detalle de productos y servicios",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: products.map(
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
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Card(
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        119,
                                                        246,
                                                        143,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MyText(
                                                          text:
                                                              "#${prod.numeroLinea}",
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          products.remove(prod);
                                                          updateProductsIndex();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ]),
                                              const SizedBox(height: 5),
                                              MyText(
                                                text: _cabysOptions[
                                                    prod.cabysId]!,
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
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const MyText(
                                                                text:
                                                                    "Tipo codigo comercial:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: _tiposCodigoComercial[
                                                                    int.parse(prod
                                                                        .tipoCodigoComercial)]!,
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
                                                                    "Codigo comercial:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .codigoComercial,
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
                                                                    "Cantidad:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .cantidad
                                                                    .toString(),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .unidadMedida,
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
                                                                    "Unidad de medida comercial:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .unidadMedidaComercial,
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
                                                                    "Detalle:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .detalle
                                                                    .toString(),
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
                                                                    "Precio unitario:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .precioUnitario
                                                                    .toString(),
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
                                                                    "Descuento:",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              MyText(
                                                                text: prod
                                                                    .descuento
                                                                    .toString(),
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
                                      const SizedBox(height: 15)
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
