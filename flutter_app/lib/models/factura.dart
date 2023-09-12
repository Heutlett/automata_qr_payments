import 'package:flutter_app/models/producto.dart';

class Factura {
  final String descripcion;

  final String cuentaEmisorId;
  final String dispositivoLector;
  final double latitudLector;
  final double longitudLector;
  final String timestampLector;

  final String cuentaReceptorId;
  final String dispositivoGenerador;
  final double latitudGenerador;
  final double longitudGenerador;
  final String timestampGenerador;

  final String codigoActividadEmisor;
  final int codigoMonedaId;
  final int condicionVenta;
  final int medioPago;

  final List<Producto> lineasDetalle;

  Factura({
    required this.codigoActividadEmisor,
    required this.dispositivoGenerador,
    required this.latitudGenerador,
    required this.longitudGenerador,
    required this.timestampGenerador,
    required this.latitudLector,
    required this.longitudLector,
    required this.dispositivoLector,
    required this.timestampLector,
    required this.cuentaEmisorId,
    required this.cuentaReceptorId,
    required this.lineasDetalle,
    required this.codigoMonedaId,
    required this.descripcion,
    required this.condicionVenta,
    required this.medioPago,
  });

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'cuentaEmisorId': cuentaEmisorId,
      'dispositivoLector': dispositivoLector,
      'latitudLector': latitudLector,
      'longitudLector': longitudLector,
      'timestampLector': timestampLector,
      'cuentaReceptorId': cuentaReceptorId,
      'dispositivoGenerador': dispositivoGenerador,
      'latitudGenerador': latitudGenerador,
      'longitudGenerador': longitudGenerador,
      'timestampGenerador': timestampGenerador,
      'codigoActividadEmisor': codigoActividadEmisor,
      'codigoMonedaId': codigoMonedaId,
      'condicionVenta': condicionVenta,
      'medioPago': medioPago,
      'lineasDetalle':
          lineasDetalle.map((producto) => producto.toJson()).toList(),
    };
  }
}
