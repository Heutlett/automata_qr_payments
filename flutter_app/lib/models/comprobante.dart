import 'account.dart';

class Comprobante {
  final int id;
  final String clave;
  final String numeroConsecutivo;
  final Account cuentaEmisor;
  final Account cuentaReceptor;
  final String descripcion;
  final String estado;
  final String codigoActividad;
  final DateTime fechaEmision;
  final String condicionVenta;
  final String medioPago;
  final String codigoMoneda;
  final double totalVenta;
  final double totalDescuentos;
  final double totalImpuesto;
  final double totalComprobante;

  Comprobante({
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.clave,
    required this.codigoActividad,
    required this.numeroConsecutivo,
    required this.fechaEmision,
    required this.codigoMoneda,
    required this.totalVenta,
    required this.condicionVenta,
    required this.medioPago,
    required this.totalDescuentos,
    required this.totalImpuesto,
    required this.totalComprobante,
    required this.cuentaEmisor,
    required this.cuentaReceptor,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'descripcion': descripcion,
      'clave': clave,
      'codigoActividad': codigoActividad,
      'numeroConsecutivo': numeroConsecutivo,
      'fechaEmision': fechaEmision,
      'codigoMoneda': codigoMoneda,
      'totalVenta': totalVenta,
      'condicionVenta': condicionVenta,
      'medioPago': medioPago,
      'totalDescuentos': totalDescuentos,
      'totalImpuesto': totalImpuesto,
      'totalComprobante': totalComprobante,
      'cuentaEmisor': cuentaEmisor.toJson(),
      'cuentaReceptor': cuentaReceptor.toJson(),
    };
  }
}
