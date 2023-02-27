import 'package:flutter/material.dart';
import '/models/account.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
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
            decoration: InputDecoration(labelText: 'Identificacion extranjero'),
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
            decoration: InputDecoration(labelText: 'Nombre comercial'),
          ),
          SizedBox(height: 16.0),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: account.telCodigoPais,
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Codigo de pais'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: account.telNumero,
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Numero'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: account.faxCodigoPais,
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Codigo de pais'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: account.faxNumero,
                    enabled: false,
                    decoration: InputDecoration(labelText: 'Numero'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            initialValue: account.correo,
            enabled: false,
            decoration: InputDecoration(labelText: 'Correo electrónico'),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.only(bottom: 16.0),
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
                  initialValue: '',
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Provincia'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: '',
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Canton'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: '',
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Distrito'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: '',
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
                  decoration:
                      InputDecoration(labelText: 'Otras señas extranjero'),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            initialValue: account.tipo,
            enabled: false,
            decoration: InputDecoration(labelText: 'Tipo cuenta'),
          ),
        ],
      ),
    );
  }
}
