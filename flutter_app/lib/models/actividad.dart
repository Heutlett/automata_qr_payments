import 'package:flutter/foundation.dart';

class Actividad {
  final String codigoActividad;
  final String nombre;
  //final List<dynamic> actividades;

  Actividad({
    required this.codigoActividad,
    required this.nombre,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Actividad &&
          runtimeType == other.runtimeType &&
          codigoActividad == other.codigoActividad &&
          nombre == other.nombre;

  @override
  int get hashCode => codigoActividad.hashCode ^ nombre.hashCode;

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      codigoActividad: json['codigoActividad'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigoActividad': codigoActividad,
      'nombre': nombre,
    };
  }
}
