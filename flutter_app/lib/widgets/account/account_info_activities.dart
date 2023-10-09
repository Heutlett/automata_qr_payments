import 'package:flutter/material.dart';
import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class AccountInfoCardActivities extends StatelessWidget {
  final List<Actividad>? activities;

  const AccountInfoCardActivities({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const MyText(
              text: 'Actividades económicas',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            const Divider(thickness: 1),
            Container(
              child: activities!.isNotEmpty
                  ? Column(
                      children: activities!.map(
                        (act) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: act.codigoActividad,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                MyText(
                                  text: act.nombre,
                                  fontSize: 12,
                                ),
                                const Divider(thickness: 1),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: const MyText(
                        text: 'No cuenta con actividades económicas',
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
