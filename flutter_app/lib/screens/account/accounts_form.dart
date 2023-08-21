import 'package:flutter/material.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';
import 'package:flutter_app/models/account.dart';

import '../../models/actividad.dart';

class AccountForm extends StatefulWidget {
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
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
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
                  text: widget.titulo,
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
                        initialValue: widget.account.cedulaTipo,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Tipo Cedula'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.cedulaNumero,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Numero Cedula'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.idExtranjero,
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Identificacion extranjero'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.nombre,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.nombreComercial,
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Nombre comercial'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.tipo,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Tipo cuenta'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                widget.isEmisor
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
                            widget.account.actividades!.isNotEmpty
                                ? Column(
                                    children: widget.account.actividades!.map(
                                      (act) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: Card(
                                            color: act.selected
                                                ? Colors.green[200]
                                                : Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          act.codigoActividad,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 16.0),
                                                      Expanded(
                                                        flex: 1,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              for (int i = 0;
                                                                  i <
                                                                      widget
                                                                          .account
                                                                          .actividades!
                                                                          .length;
                                                                  i++) {
                                                                widget
                                                                    .account
                                                                    .actividades![
                                                                        i]
                                                                    .selected = false;
                                                              }
                                                              act.selected =
                                                                  true;
                                                            });
                                                          },
                                                          child: const Text(
                                                              "Seleccionar"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    act.nombre,
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
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
                widget.isEmisor
                    ? const SizedBox(height: 16.0)
                    : const SizedBox(),
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
                              initialValue: widget.account.telCodigoPais,
                              enabled: false,
                              decoration: const InputDecoration(
                                  labelText: 'Codigo de pais'),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: widget.account.telNumero,
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
                              initialValue: widget.account.faxCodigoPais,
                              enabled: false,
                              decoration: const InputDecoration(
                                  labelText: 'Codigo de pais'),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: widget.account.faxNumero,
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
                        initialValue: widget.account.correo,
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
                        initialValue: widget.account.nombreProvincia,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Provincia'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.nombreCanton,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Canton'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.nombreDistrito,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Distrito'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.nombreBarrio,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Barrio'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.ubicacionSenas,
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Otras señas'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: widget.account.ubicacionSenasExtranjero,
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
