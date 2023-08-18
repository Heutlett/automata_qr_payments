import 'package:flutter/material.dart';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/models/server_response.dart';

import '../../models/record.dart';
import '../../services/factura/factura_service.dart';

class RecordsPage extends StatelessWidget {
  RecordsPage({Key? key}) : super(key: key);

  List<Record> data = [
    Record(
      id: 1,
      numeroConsecutivo: '123456',
      fechaEmision: DateTime(2023, 8, 14),
      codigoMonedaId: 1,
      descripcion: "1 Litro de diesel",
      estado: "En espera",
    ),
    Record(
      id: 2,
      numeroConsecutivo: '789132',
      fechaEmision: DateTime(2023, 8, 15),
      codigoMonedaId: 1,
      descripcion: "1 Litro de diesel",
      estado: "En espera",
    ),
    Record(
      id: 3,
      numeroConsecutivo: '123321',
      fechaEmision: DateTime(2023, 8, 16),
      codigoMonedaId: 1,
      descripcion: "1 Litro de diesel",
      estado: "En espera",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Historial de pagos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Consecutivo"),
                  Text("Fecha"),
                  Text("Descripción"),
                  Text("Moneda"),
                  Text("Estado")
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Record record = data[index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(record.numeroConsecutivo),
                        Text(record.fechaEmision.toString().substring(0, 12)),
                        Text(record.descripcion),
                        Text(record.codigoMonedaId.toString()),
                        Text(record.estado)
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getComprobantesSummary();
                },
                child: Text("Press me"),
              )
            ],
          ),
        ));
  }

  void getComprobantesSummary() async {
    ServerResponse<ComprobanteSummary> response =
        await getComprobanteSummary(2);

    print(response.data!.id.toString());
    print(response.message);
  }
}
