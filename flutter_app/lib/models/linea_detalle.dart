class LineaDetalle {
  int numeroLinea;
  final int cabysId;
  final String tipoCodigoComercial;
  final String codigoComercial;
  final int cantidad;
  final String unidadMedida;
  final String unidadMedidaComercial;
  final String detalle;
  final int precioUnitario;
  final int descuento;

  LineaDetalle({
    required this.numeroLinea,
    required this.cabysId,
    required this.tipoCodigoComercial,
    required this.codigoComercial,
    required this.cantidad,
    required this.unidadMedida,
    required this.unidadMedidaComercial,
    required this.detalle,
    required this.precioUnitario,
    required this.descuento,
  });

  Map<String, dynamic> toJson() {
    return {
      'numeroLinea': numeroLinea,
      'cabysId': cabysId,
      'tipoCodigoComercial': tipoCodigoComercial,
      'codigoComercial': codigoComercial,
      'cantidad': cantidad,
      'unidadMedida': unidadMedida,
      'unidadMedidaComercial': unidadMedidaComercial,
      'detalle': detalle,
      'precioUnitario': precioUnitario,
      'descuento': descuento,
    };
  }
}
