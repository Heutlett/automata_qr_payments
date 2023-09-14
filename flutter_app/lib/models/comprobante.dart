import 'package:flutter_app/models/detalle_comprobante.dart';

import 'account.dart';

class Comprobante {
  final int id;
  final Account cuentaEmisor;
  final Account cuentaReceptor;

  final DetalleComprobante detalleComprobante;

  /// lineas detalle
  final String tipoDoc;
  final String estado;
  final String descripcion;
  final String clave;
  final String codigoActividad;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final String condicionVenta;
  final String medioPago;
  final String codigoMoneda;

  final double totalServGravados;
  final double totalServExentos;
  final double totalServExonerado;
  final double totalMercanciasGravadas;
  final double totalMercExonerada;
  final double totalGravado;
  final double totalExonerado;
  final double totalVenta;
  final double totalDescuentos;

  final double totalVentaNeta;
  final double totalImpuesto;

  final double totalIVADevuelto;
  final double totalOtrosCargos;
  final double totalComprobante;

  Comprobante({
    required this.detalleComprobante,
    required this.tipoDoc,
    required this.totalServGravados,
    required this.totalServExentos,
    required this.totalServExonerado,
    required this.totalMercanciasGravadas,
    required this.totalMercExonerada,
    required this.totalGravado,
    required this.totalExonerado,
    required this.totalVentaNeta,
    required this.totalIVADevuelto,
    required this.totalOtrosCargos,
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
      'cuentaEmisor': cuentaEmisor.toJson(),
      'cuentaReceptor': cuentaReceptor.toJson(),

      'detalleComprobante': detalleComprobante.toJson(),

      /// lineas detalle
      'tipoDoc': tipoDoc,
      'estado': estado,
      'descripcion': descripcion,
      'clave': clave,
      'codigoActividad': codigoActividad,
      'numeroConsecutivo': numeroConsecutivo,
      'fechaEmision': fechaEmision,
      'condicionVenta': condicionVenta,
      'medioPago': medioPago,
      'codigoMoneda': codigoMoneda,
      'totalServGravados': totalServGravados,
      'totalServExentos': totalServExentos,
      'totalServExonerado': totalServExonerado,
      'totalMercanciasGravadas': totalMercanciasGravadas,
      'totalMercExonerada': totalMercExonerada,
      'totalGravado': totalGravado,
      'totalExonerado': totalExonerado,
      'totalVenta': totalVenta,
      'totalDescuentos': totalDescuentos,
      'totalVentaNeta': totalVentaNeta,
      'totalImpuesto': totalImpuesto,
      'totalIVADevuelto': totalIVADevuelto,
      'totalOtrosCargos': totalOtrosCargos,
      'totalComprobante': totalComprobante,
    };
  }
}
