import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class AccountInfoCardExpand extends StatelessWidget {
  final Account account;

  const AccountInfoCardExpand({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const MyText(
              text: 'Identificación',
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            account.idExtranjero.isNotEmpty
                ? TextFormField(
                    initialValue: account.idExtranjero,
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: 'Identificación extranjero',
                        labelStyle: TextStyle(fontSize: 15)),
                  )
                : const SizedBox(),
            TextFormField(
              initialValue: account.nombreComercial,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Nombre comercial',
                labelStyle: TextStyle(fontSize: 15),
                disabledBorder: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
            TextFormField(
              initialValue: account.tipo,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Tipo cuenta',
                labelStyle: TextStyle(fontSize: 15),
                disabledBorder: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: 'Telefono',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: account.telCodigoPais,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Codigo de pais',
                            labelStyle: TextStyle(fontSize: 15),
                            disabledBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          initialValue: account.telNumero,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Número',
                            labelStyle: TextStyle(fontSize: 15),
                            disabledBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  account.faxCodigoPais.isEmpty && account.faxNumero.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            const MyText(
                              text: 'Fax',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: account.faxCodigoPais,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Codigo de pais',
                                      labelStyle: TextStyle(fontSize: 15),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    initialValue: account.faxNumero,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      labelText: 'Numero',
                                      labelStyle: TextStyle(fontSize: 15),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 8),
                  const MyText(
                    text: 'Correo electrónico',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  TextFormField(
                    initialValue: account.correo,
                    enabled: false,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                    decoration: const InputDecoration(
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const MyText(
                    text: 'Ubicación',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  TextFormField(
                    initialValue: account.nombreProvincia,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Provincia',
                      labelStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  TextFormField(
                    initialValue: account.nombreCanton,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Cantón',
                      labelStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  TextFormField(
                    initialValue: account.nombreDistrito,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Distrito',
                      labelStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  TextFormField(
                    initialValue: account.nombreBarrio,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Barrio',
                      labelStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  const Text('Otras señas',
                      style: TextStyle(
                          fontSize: 11.3,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text(account.ubicacionSenas,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black)),
                  account.ubicacionSenasExtranjero.isNotEmpty
                      ? TextFormField(
                          initialValue: account.ubicacionSenasExtranjero,
                          enabled: false,
                          decoration: const InputDecoration(
                              labelText: 'Otras señas extranjero',
                              labelStyle: TextStyle(fontSize: 15)),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
