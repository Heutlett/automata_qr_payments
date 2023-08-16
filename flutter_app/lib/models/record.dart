class Record {
  final int id;
  final DateTime fechaEmision;
  final String numeroConsecutivo;
  final String descripcion;
  final int codigoMonedaId;
  final String estado;
  Record({
    required this.id,
    required this.fechaEmision,
    required this.numeroConsecutivo,
    required this.descripcion,
    required this.codigoMonedaId,
    required this.estado,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fechaEmision': fechaEmision,
      'numeroConsecutivo': numeroConsecutivo,
      'descripcion': descripcion,
      'codigoMonedaId': codigoMonedaId,
      'estado': estado,
    };
  }
}
