import 'dart:convert';
import 'package:flutter/services.dart';

class Ubicacion {
  Provincia provincia;
  Canton canton;
  Distrito distrito;
  Barrio barrio;

  Ubicacion(
      {required this.provincia,
      required this.canton,
      required this.distrito,
      required this.barrio});
}

class Provincia {
  final int id;
  final String nombre;

  Provincia({required this.id, required this.nombre});
}

class Canton {
  final int id;
  final String nombre;

  Canton({required this.id, required this.nombre});
}

class Distrito {
  final int id;
  final String nombre;

  Distrito({required this.id, required this.nombre});
}

class Barrio {
  final int id;
  final String nombre;

  Barrio({required this.id, required this.nombre});
}

class UbicacionService {
  Future<List<Provincia>> getProvincias() async {
    String jsonContent =
        await rootBundle.loadString('assets/data/ubicaciones.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    List<Provincia> provincias = [];

    jsonData.forEach((provinciaId, provinciaData) {
      Provincia provincia = Provincia(
        id: int.parse(provinciaId),
        nombre: provinciaData['nombre_provincia'],
      );
      provincias.add(provincia);
    });

    return provincias;
  }

  Future<List<Canton>> getCantonesByProvincia(int provincia) async {
    String jsonContent =
        await rootBundle.loadString('assets/data/ubicaciones.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    List<Canton> cantones = [];

    if (jsonData.containsKey(provincia.toString())) {
      Map<String, dynamic> provinciaData = jsonData[provincia.toString()];
      provinciaData['cantones'].forEach((cantonId, cantonData) {
        Canton canton = Canton(
          id: int.parse(cantonId),
          nombre: cantonData['nombre_canton'],
        );
        cantones.add(canton);
      });
    }

    return cantones;
  }

  Future<List<Distrito>> getDistritosByCanton(int provincia, int canton) async {
    String jsonContent =
        await rootBundle.loadString('assets/data/ubicaciones.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    List<Distrito> distritos = [];

    if (jsonData.containsKey(provincia.toString())) {
      Map<String, dynamic> provinciaData = jsonData[provincia.toString()];
      if (provinciaData['cantones'].containsKey(canton.toString())) {
        Map<String, dynamic> cantonData =
            provinciaData['cantones'][canton.toString()];
        cantonData['distritos'].forEach((distritoId, distritoData) {
          Distrito distrito = Distrito(
            id: int.parse(distritoId),
            nombre: distritoData['nombre_distrito'],
          );
          distritos.add(distrito);
        });
      }
    }

    return distritos;
  }

  Future<List<Barrio>> getBarriosByDistrito(
      int provincia, int canton, int distrito) async {
    String jsonContent =
        await rootBundle.loadString('assets/data/ubicaciones.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    List<Barrio> barrios = [];

    if (jsonData.containsKey(provincia.toString())) {
      Map<String, dynamic> provinciaData = jsonData[provincia.toString()];
      if (provinciaData['cantones'].containsKey(canton.toString())) {
        Map<String, dynamic> cantonData =
            provinciaData['cantones'][canton.toString()];
        if (cantonData['distritos'].containsKey(distrito.toString())) {
          Map<String, dynamic> distritoData =
              cantonData['distritos'][distrito.toString()];
          distritoData['barrios'].forEach((barrioId, nombreBarrio) {
            Barrio barrio = Barrio(
              id: int.parse(barrioId),
              nombre: nombreBarrio,
            );
            barrios.add(barrio);
          });
        }
      }
    }

    return barrios;
  }

  Future<Ubicacion?> getUbicacion(String codigo) async {
    if (codigo.length != 7) {
      throw Exception('El código debe tener 7 dígitos.');
    }

    int provinciaId = int.parse(codigo.substring(0, 1));
    int cantonId = int.parse(codigo.substring(1, 3));
    int distritoId = int.parse(codigo.substring(3, 5));
    int barrioId = int.parse(codigo.substring(5, 7));

    List<Provincia> provincias = await getProvincias();
    Provincia? provincia = provincias.firstWhere((p) => p.id == provinciaId);

    List<Canton> cantones = await getCantonesByProvincia(provinciaId);
    Canton? canton = cantones.firstWhere((c) => c.id == cantonId);

    List<Distrito> distritos =
        await getDistritosByCanton(provinciaId, cantonId);
    Distrito? distrito = distritos.firstWhere((d) => d.id == distritoId);

    List<Barrio> barrios =
        await getBarriosByDistrito(provinciaId, cantonId, distritoId);
    Barrio? barrio = barrios.firstWhere((b) => b.id == barrioId);

    return Ubicacion(
      provincia: provincia,
      canton: canton,
      distrito: distrito,
      barrio: barrio,
    );
  }
}
