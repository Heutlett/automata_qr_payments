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
  String? _tipoMoneda = 'Colones';

  final List<String> _tiposMoneda = ['Colones', 'Dolares'];

  final List<Producto> productos = [];

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
            ),
            AccountForm(
              titulo: 'Datos receptor',
              account: accountReceptor,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(text: 'Tipo moneda:'),
                      DropdownButton<String>(
                        value: _tipoMoneda,
                        onChanged: (newValue) {
                          setState(() {
                            _tipoMoneda = newValue;
                          });
                        },
                        items: _tiposMoneda
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
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
                        context, accountEmisor, accountReceptor, productos);
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
      Account accountReceptor, List<Producto> productos) {
    Factura factura = Factura(
        emisor: accountEmisor,
        receptor: accountReceptor,
        productos: productos,
        tipoMoneda: _tipoMoneda!);

    Navigator.of(context).pushNamed("/show_factura_json", arguments: factura);
  }
}
