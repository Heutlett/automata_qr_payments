import 'package:flutter/material.dart';
import 'dart:convert';

import '../../models/factura.dart';
import '../../services/factura/factura_service.dart';
import '../../utils/utils.dart';
import '../widgets/general/my_text.dart';

class FacturaScreen extends StatelessWidget {
  const FacturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    final Factura factura = args[0];

    String facturaJson = jsonEncode(factura);

    Map<String, dynamic> jsonDataFactura = json.decode(facturaJson);

    String formattedFacturaJson =
        const JsonEncoder.withIndent('  ').convert(jsonDataFactura);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Color del borde
                        width: 2.0, // Ancho del borde
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Text(
                        formattedFacturaJson,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  sendFacturaHacienda(context, factura);
                },
                child: const SizedBox(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: MyText(
                      text: "Enviar a hacienda",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  void sendFacturaHacienda(
    BuildContext context,
    Factura factura,
  ) async {
    var response = await postAddComprobante(factura);

    if (context.mounted) {
      if (response.statusCode == 200) {
        showAlertDialogWithRoute(context, 'Factura enviada',
            'La factura se envió exitosamente.', 'Aceptar', '/home_logged');
      } else {
        showAlertDialog(context, 'Error al enviar factura',
            'Ocurrió un error al enviar la factura.', 'Aceptar');
      }
    }
  }
}
