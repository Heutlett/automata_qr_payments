import 'package:flutter/foundation.dart';

import 'actividad.dart';

class Account {
  final String id;
  final String cedulaTipo;
  final String cedulaNumero;
  final String idExtranjero;
  final String nombre;
  final String nombreComercial;
  final String telCodigoPais;
  final String telNumero;
  final String faxCodigoPais;
  final String faxNumero;
  final String correo;
  final String ubicacionCodigo;
  final String ubicacionSenas;
  final String ubicacionSenasExtranjero;
  final String tipo;
  final List<Actividad>? actividades;

  Account({
    required this.id,
    required this.cedulaTipo,
    required this.cedulaNumero,
    required this.idExtranjero,
    required this.nombre,
    required this.nombreComercial,
    required this.telCodigoPais,
    required this.telNumero,
    required this.faxCodigoPais,
    required this.faxNumero,
    required this.correo,
    required this.ubicacionCodigo,
    required this.ubicacionSenas,
    required this.ubicacionSenasExtranjero,
    required this.tipo,
    required this.actividades,
  });
}
