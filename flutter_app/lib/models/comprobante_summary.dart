class ComprobanteSummary {
  final int id;
  final String estado;
  final String descripcion;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final int codigoMonedaId;
  final double totalComprobante;

  ComprobanteSummary({
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.numeroConsecutivo,
    required this.fechaEmision,
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
      'codigoMonedaId': codigoMonedaId,
      'totalComprobante': totalComprobante,
    };
  }
}
