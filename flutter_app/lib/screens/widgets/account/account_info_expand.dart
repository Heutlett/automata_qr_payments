import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

class AccountInfoCardExpand extends StatelessWidget {
  final Account account;

  const AccountInfoCardExpand({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              initialValue: account.idExtranjero,
              enabled: false,
              decoration:
                  const InputDecoration(labelText: 'Identificacion extranjero'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: account.nombreComercial,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Nombre comercial'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: account.tipo,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Tipo cuenta'),
            ),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: 'Telefono',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: account.telCodigoPais,
                          enabled: false,
                          decoration: const InputDecoration(
                              labelText: 'Codigo de pais'),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          initialValue: account.telNumero,
                          enabled: false,
                          decoration:
                              const InputDecoration(labelText: 'Numero'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const MyText(
                    text: 'Fax',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: account.faxCodigoPais,
                          enabled: false,
                          decoration: const InputDecoration(
                              labelText: 'Codigo de pais'),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          initialValue: account.faxNumero,
                          enabled: false,
                          decoration:
                              const InputDecoration(labelText: 'Numero'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const MyText(
                    text: 'Correo electrónico',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  TextFormField(
                    initialValue: account.correo,
                    enabled: false,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: 'Ubicación',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.nombreProvincia,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Provincia'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.nombreCanton,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Canton'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.nombreDistrito,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Distrito'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.nombreBarrio,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Barrio'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.ubicacionSenas,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Otras señas'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: account.ubicacionSenasExtranjero,
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: 'Otras señas extranjero'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
