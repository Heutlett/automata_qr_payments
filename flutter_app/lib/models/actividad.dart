import 'dart:convert';
import 'package:flutter/services.dart';

class Actividad {
  final String codigoActividad;
  final String nombre;

  static Actividad nullActivity =
      Actividad(codigoActividad: '0', nombre: 'Null');

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

  static Future<List<Actividad>> cargarActividades() async {
    // Lee el contenido del archivo JSON
    String jsonString =
        await rootBundle.loadString('assets/data/actividades.json');

    // Decodifica el JSON en un mapa
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Mapea los elementos del mapa a una lista de objetos Actividad
    List<Actividad> actividades = jsonMap.entries.map((entry) {
      return Actividad(
        codigoActividad: entry.key,
        nombre: entry.value,
      );
    }).toList();

    return actividades;
  }
}
