import 'package:flutter/foundation.dart';

import 'actividad.dart';

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
