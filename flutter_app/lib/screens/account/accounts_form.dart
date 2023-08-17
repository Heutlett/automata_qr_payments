import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';
import 'package:flutter_app/models/account.dart';

class AccountForm extends StatelessWidget {
  final String titulo;
  final Account account;
  final bool isEmisor;

  const AccountForm({
    super.key,
    required this.titulo,
    required this.account,
    required this.isEmisor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                MyText(
                  text: titulo,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      const MyText(
                        text: 'Identificacion',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        initialValue: account.cedulaTipo,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Tipo Cedula'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.cedulaNumero,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Numero Cedula'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.idExtranjero,
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Identificacion extranjero'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombre,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreComercial,
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Nombre comercial'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.tipo,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Tipo cuenta'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                isEmisor
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            const Text(
                              'Actividades economicas',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            account.actividades!.isNotEmpty
                                ? Column(
                                    children: account.actividades!.map(
                                      (act) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: Card(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        act.codigoActividad,
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16.0),
                                                    Expanded(
                                                      flex: 1,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "Seleccionar"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  act.nombre,
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  )
                                : const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'No cuenta con actividades económicas',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                isEmisor ? const SizedBox(height: 16.0) : const SizedBox(),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Telefono',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                      const Text(
                        'Fax',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                      const Text(
                        'Correo electrónico',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ubicación',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreProvincia,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Provincia'),
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
                        decoration:
                            const InputDecoration(labelText: 'Distrito'),
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
                        decoration:
                            const InputDecoration(labelText: 'Otras señas'),
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
        ],
      ),
    );
  }
}
