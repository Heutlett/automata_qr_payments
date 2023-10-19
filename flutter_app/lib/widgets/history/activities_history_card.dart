import 'package:flutter/material.dart';
import 'package:flutter_app/models/activity_history.dart';
import 'package:intl/intl.dart';

class ActivityHistoryCard extends StatelessWidget {
  final ActivityHistory activityHistory;

  const ActivityHistoryCard({super.key, required this.activityHistory});

  @override
  Widget build(BuildContext context) {
    // Formatear la fecha
    DateTime parsedDate = DateTime.parse(activityHistory.fecha);
    String fechaFormateada = DateFormat('dd/MM/yyyy').format(parsedDate);

    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Fecha: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(fechaFormateada),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const Text(
                          'Acción: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(activityHistory.accion),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Cuenta involucrada: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(activityHistory.cuentaNombre)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
