class Producto {
  final String nombre;
  final double cantidad;
  final String unidadMedida;
  final String detalle;
  final double precioUnitario;
  final double descuento;
  final double montoTotal;
  Producto(
      {required this.nombre,
      required this.cantidad,
      required this.unidadMedida,
      required this.detalle,
      required this.precioUnitario,
      required this.descuento,
      required this.montoTotal});
}
