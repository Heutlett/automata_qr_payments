import 'package:flutter_app/models/producto.dart';

import 'account.dart';

class Factura {
  final Account emisor;
  final Account receptor;
  final List<Producto> productos;
  final int idMoneda;
  final String descripcion;
  final int condicionVenta;
  final int medioPago;

  Factura({
    required this.emisor,
    required this.receptor,
    required this.productos,
    required this.idMoneda,
    required this.descripcion,
    required this.condicionVenta,
    required this.medioPago,
  });

  Map<String, dynamic> toJson() {
    return {
      'emisor': emisor.toJson(),
      'receptor': receptor.toJson(),
      'productos': productos.map((producto) => producto.toJson()).toList(),
      'idMoneda': idMoneda,
      'descripcion': descripcion,
      'condicionVenta': condicionVenta,
      'medioPago': medioPago,
    };
  }
}
