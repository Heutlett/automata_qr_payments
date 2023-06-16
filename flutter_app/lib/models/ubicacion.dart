class Ubicacion {
  String provincia;
  String canton;
  String distrito;
  String barrio;

  Ubicacion(
      {required this.provincia,
      required this.canton,
      required this.distrito,
      required this.barrio});
}

List<Provincia> provincias = [
  Provincia(id: 1, nombre: 'SAN JOSE'),
  Provincia(id: 2, nombre: 'ALAJUELA'),
  Provincia(id: 3, nombre: 'CARTAGO'),
  Provincia(id: 4, nombre: 'HEREDIA'),
  Provincia(id: 5, nombre: 'GUANACASTE'),
  Provincia(id: 6, nombre: 'PUNTARENAS'),
  Provincia(id: 7, nombre: 'LIMON'),
];

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
