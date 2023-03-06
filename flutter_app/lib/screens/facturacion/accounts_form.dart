import 'package:flutter/material.dart';
import 'package:flutter_app/models/serverResponse.dart';
import '../../models/ubicacion.dart';
import '/models/account.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

class AccountForm extends StatelessWidget {
  final String titulo;
  final Account account;

  AccountForm({
    required this.titulo,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 232, 232),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Identificacion',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        initialValue: account.cedulaTipo,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Tipo Cedula'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.cedulaNumero,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Numero Cedula'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.idExtranjero,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Identificacion extranjero'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombre,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Nombre'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreComercial,
                        enabled: false,
                        decoration:
                            InputDecoration(labelText: 'Nombre comercial'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.tipo,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Tipo cuenta'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Actividades economicas',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      account.actividades!.length != 0
                          ? Column(
                              children: account.actividades!.map(
                                (act) {
                                  return Container(
                                    width: double.infinity,
                                    child: Card(
                                      child: Container(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  act.codigoActividad,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(width: 16.0),
                                              Expanded(
                                                flex: 1,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("Seleccionar"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            act.nombre,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      )),
                                    ),
                                  );
                                },
                              ).toList(),
                            )
                          : Container(
                              width: double.infinity,
                              child: Text(
                                'No cuenta con actividades económicas',
                                style: TextStyle(color: Colors.red),
                              )),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telefono',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: account.telCodigoPais,
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: 'Codigo de pais'),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                initialValue: account.telNumero,
                                enabled: false,
                                decoration:
                                    InputDecoration(labelText: 'Numero'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Fax',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: account.faxCodigoPais,
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: 'Codigo de pais'),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                initialValue: account.faxNumero,
                                enabled: false,
                                decoration:
                                    InputDecoration(labelText: 'Numero'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
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
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ubicación',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreProvincia,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Provincia'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreCanton,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Canton'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreDistrito,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Distrito'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.nombreBarrio,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Barrio'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.ubicacionSenas,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Otras señas'),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        initialValue: account.ubicacionSenasExtranjero,
                        enabled: false,
                        decoration: InputDecoration(
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
