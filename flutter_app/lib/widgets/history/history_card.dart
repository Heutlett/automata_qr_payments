import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/widgets/history/history_details_modal.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final int id;
  final String estado;
  final String descripcion;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final int codigoMonedaId;
  final double totalComprobante;

  const HistoryCard({
    super.key,
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.numeroConsecutivo,
    required this.fechaEmision,
    required this.codigoMonedaId,
    required this.totalComprobante,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openAlertModal(context, id);
      },
      child: Card(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 182, 182, 182),
                child: Row(
                  children: [
                    Text("  # $numeroConsecutivo"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(fechaEmision.toLocal()),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(estado),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(children: [
                            Text(descripcion),
                          ]),
                        ),
                        Text(
                          " ${codigosMoneda[codigoMonedaId]} ${totalComprobante.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: totalComprobante >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAlertModal(BuildContext context, int comprobanteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return HistoryDetailsModal(comprobanteId: comprobanteId);
            },
          ),
        );
      },
    );
  }
}
