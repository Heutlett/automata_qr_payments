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
