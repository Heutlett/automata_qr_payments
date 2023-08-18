import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final String estado;
  final String descripcion;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final int codigoMonedaId;
  final double totalComprobante;

  final Map<int, String> codigosMoneda = {
    56: "₡",
    250: "\$",
  };

  RecordCard({
    super.key,
    required this.estado,
    required this.descripcion,
    required this.numeroConsecutivo,
    required this.fechaEmision,
    required this.codigoMonedaId,
    required this.totalComprobante,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue[100],
        child: Column(
          children: [
            Card(
              color: Colors.grey,
              child: Row(
                children: [
                  Text("# $numeroConsecutivo"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${fechaEmision.day}/${fechaEmision.month}/${fechaEmision.year} ${fechaEmision.hour}:${fechaEmision.minute <= 9 ? "0${fechaEmision.minute.toString()}" : fechaEmision.minute}",
                    ),
                    Text(estado),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(descripcion),
                    Text(
                      " ${codigosMoneda[codigoMonedaId]} ${totalComprobante.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            totalComprobante >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }
}
