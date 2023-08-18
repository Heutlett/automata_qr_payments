class ComprobanteSummary {
  final int id;
  final int estado;
  final String descripcion;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final int cuentaEmisorId;
  final int cuentaReceptorId;
  final int codigoMonedaId;
  final int totalComprobante;

  ComprobanteSummary({
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.numeroConsecutivo,
    required this.fechaEmision,
    required this.cuentaEmisorId,
    required this.cuentaReceptorId,
    required this.codigoMonedaId,
    required this.totalComprobante,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'descripcion': descripcion,
      'numeroConsecutivo': numeroConsecutivo,
      'fechaEmision': fechaEmision,
      'cuentaEmisorId': cuentaEmisorId,
      'cuentaReceptorId': cuentaReceptorId,
      'codigoMonedaId': codigoMonedaId,
      'totalComprobante': totalComprobante,
    };
  }
}
