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
  String? nombreProvincia;
  String? nombreCanton;
  String? nombreDistrito;
  String? nombreBarrio;
  final bool esCompartida;
  final List<UsuarioCompartido> usuariosCompartidos;

  Account(
      {required this.id,
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
      this.nombreProvincia,
      this.nombreCanton,
      this.nombreDistrito,
      this.nombreBarrio,
      required this.esCompartida,
      required this.usuariosCompartidos});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cedulaTipo': cedulaTipo,
      'cedulaNumero': cedulaNumero,
      'idExtranjero': idExtranjero,
      'nombre': nombre,
      'nombreComercial': nombreComercial,
      'telCodigoPais': telCodigoPais,
      'telNumero': telNumero,
      'faxCodigoPais': faxCodigoPais,
      'faxNumero': faxNumero,
      'correo': correo,
      'ubicacionCodigo': ubicacionCodigo,
      'ubicacionSenas': ubicacionSenas,
      'ubicacionSenasExtranjero': ubicacionSenasExtranjero,
      'tipo': tipo,
      'actividades':
          actividades?.map((actividad) => actividad.toJson()).toList(),
      'nombreProvincia': nombreProvincia,
      'nombreCanton': nombreCanton,
      'nombreDistrito': nombreDistrito,
      'nombreBarrio': nombreBarrio,
      'esCompartida': esCompartida,
      'usuariosCompartidos':
          usuariosCompartidos.map((usuario) => usuario.toJson()).toList(),
    };
  }
}

class UsuarioCompartido {
  final String nombreCompleto;
  final String username;

  UsuarioCompartido({
    required this.nombreCompleto,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'username': username,
    };
  }
}
