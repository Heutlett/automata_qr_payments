import 'package:flutter_app/models/linea_detalle.dart';

class Factura {
  final String descripcion;

  final String cuentaEmisorId;
  final String dispositivoEmisor;
  final double latitudEmisor;
  final double longitudEmisor;
  final String timestampEmisor;

  final String cuentaReceptorId;
  final String dispositivoReceptor;
  final double latitudReceptor;
  final double longitudReceptor;
  final String timestampReceptor;

  final String codigoActividadEmisor;
  final int codigoMonedaId;
  final int condicionVenta;
  final int medioPago;

  final List<LineaDetalle> lineasDetalle;

  Factura({
    required this.codigoActividadEmisor,
    required this.dispositivoReceptor,
    required this.latitudReceptor,
    required this.longitudReceptor,
    required this.timestampReceptor,
    required this.latitudEmisor,
    required this.longitudEmisor,
    required this.dispositivoEmisor,
    required this.timestampEmisor,
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
      'dispositivoEmisor': dispositivoEmisor,
      'latitudEmsior': latitudEmisor,
      'longitudEmsior': longitudEmisor,
      'timestampEmsior': timestampEmisor,
      'cuentaReceptorId': cuentaReceptorId,
      'dispositivoReceptor': dispositivoReceptor,
      'latitudReceptor': latitudReceptor,
      'longitudReceptor': longitudReceptor,
      'timestampReceptor': timestampReceptor,
      'codigoActividadEmisor': codigoActividadEmisor,
      'codigoMonedaId': codigoMonedaId,
      'condicionVenta': condicionVenta,
      'medioPago': medioPago,
      'lineasDetalle':
          lineasDetalle.map((producto) => producto.toJson()).toList(),
    };
  }
}
