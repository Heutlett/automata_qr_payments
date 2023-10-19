class ActivityHistory {
  final int id;
  final String fecha;
  final String accion;
  final int cuentaId;
  final String cuentaNombre;

  ActivityHistory({
    required this.id,
    required this.fecha,
    required this.accion,
    required this.cuentaId,
    required this.cuentaNombre,
  });
}
