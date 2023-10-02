import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class AccountInfoCardHeader extends StatelessWidget {
  final String cedulaTipo;
  final String cedulaNumero;
  final String nombre;
  final String alias;

  const AccountInfoCardHeader({
    super.key,
    required this.cedulaTipo,
    required this.cedulaNumero,
    required this.nombre,
    required this.alias,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 12),
                MyText(
                  text: cedulaNumero,
                  fontSize: 12,
                ),
              ],
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    alias.isNotEmpty ? alias : 'Sin alias',
                    style: TextStyle(
                      fontSize: 12,
                      color: alias.isNotEmpty ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 5,
                  child: VerticalDivider(thickness: 1),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    nombre,
                    style: TextStyle(fontSize: 12),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
