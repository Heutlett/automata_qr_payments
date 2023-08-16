import 'package:flutter_app/models/producto.dart';

import 'account.dart';

class Factura {
  final Account emisor;
  final Account receptor;
  final List<Producto> productos;
  final String tipoMoneda;

  Factura(
      {required this.emisor,
      required this.receptor,
      required this.productos,
      required this.tipoMoneda});

  Map<String, dynamic> toJson() {
    return {
      'emisor': emisor.toJson(),
      'receptor': receptor.toJson(),
      'productos': productos.map((producto) => producto.toJson()).toList(),
    };
  }
}
