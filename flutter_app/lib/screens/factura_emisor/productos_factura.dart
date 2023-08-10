import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

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

  final List<String> _unidades_medida = ['Al', 'Alc', 'Cm', 'I', 'Os', 'Sp'];

  final _cantidadController = TextEditingController();
  final _detalleController = TextEditingController();
  final _precioUnitarioController = TextEditingController();
  final _montoTotalController = TextEditingController();

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
    // TODO: implement dispose
    super.dispose();
    _cantidadController.dispose();
    _precioUnitarioController.dispose();
    _montoTotalController.dispose();
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
                  text: "Detalle de productos",
                  fontSize: 26.0,
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
                        text: 'Agregar producto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        value: _selectedOptionProduct,
                        decoration: const InputDecoration(
                          labelText: 'Seleccionar producto',
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
                              style: TextStyle(fontSize: 15),
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
                                  icon: Icon(Icons.remove_circle),
                                  iconSize: 45,
                                  color: Colors.red,
                                  onPressed: _decrementQuantity,
                                ),
                                SizedBox(width: 10),
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
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.add_circle),
                                  color: Colors.green,
                                  iconSize: 45,
                                  onPressed: _incrementQuantity,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: 'Unidad de medida:'),
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
                                    style: TextStyle(fontSize: 15),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
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
                        controller: _detalleController,
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
                        controller: _detalleController,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
