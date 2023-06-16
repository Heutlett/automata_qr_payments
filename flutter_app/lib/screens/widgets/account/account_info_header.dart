import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

class AccountInfoCardHeader extends StatelessWidget {
  final String cedulaTipo;
  final String cedulaNumero;
  final String nombre;

  const AccountInfoCardHeader({
    super.key,
    required this.cedulaTipo,
    required this.cedulaNumero,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: cedulaTipo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 16),
                MyText(
                  text: cedulaNumero,
                  fontSize: 15,
                ),
              ],
            ),
            const Divider(thickness: 1),
            MyText(
              text: nombre,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
