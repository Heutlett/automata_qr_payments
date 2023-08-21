import 'package:flutter/material.dart';
import 'dart:convert';

import '../../models/actividad.dart';
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

    final Actividad actividadEmisor = args[1];

    String facturaJson = jsonEncode(factura);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  facturaJson,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  sendFacturaHacienda(context, factura, actividadEmisor);
                },
                child: const SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                        child: MyText(
                            text: "Enviar a hacienda",
                            fontSize: 20,
                            color: Colors.white))),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendFacturaHacienda(
      BuildContext context, Factura factura, Actividad actividadEmisor) async {
    final facturaObj = {
      "cuentaEmisorId": factura.emisor.id,
      "cuentaReceptorId": factura.receptor.id,
      "descripcion": factura.descripcion,
      "codigoActividadEmisor": actividadEmisor.codigoActividad,
      "codigoMonedaId": factura.idMoneda,
      "condicionVenta": factura.condicionVenta,
      "medioPago": factura.medioPago,
      "dispositivoLector": "1",
      "dispositivoGenerador": "1",
      "latitudLector": 0,
      "longitudLector": 0,
      "timestampLector": "2023-08-17T15:13:04.157Z",
      "latitudGenerador": 0,
      "longitudGenerador": 0,
      "timestampGenerador": "2023-08-17T15:13:04.157Z",
      "lineasDetalle": factura.productos
    };

    var response = await postAddComprobante(facturaObj);

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
