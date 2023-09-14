class DetalleComprobante {
  final int id;
  final String dispositivoEmisor;
  final double latitudEmisor;
  final double longitudEmisor;
  final DateTime timestampEmisor;
  final String dispositivoReceptor;
  final double latitudReceptor;
  final double longitudReceptor;
  final DateTime timestampReceptor;

  DetalleComprobante({
    required this.id,
    required this.dispositivoEmisor,
    required this.latitudEmisor,
    required this.longitudEmisor,
    required this.timestampEmisor,
    required this.dispositivoReceptor,
    required this.latitudReceptor,
    required this.longitudReceptor,
    required this.timestampReceptor,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dispositivoEmisor': dispositivoEmisor,
      'latitudEmisor': latitudEmisor,
      'longitudEmisor': longitudEmisor,
      'timestampEmisor': timestampEmisor,
      'dispositivoReceptor': dispositivoReceptor,
      'latitudReceptor': latitudReceptor,
      'longitudReceptor': longitudReceptor,
      'timestampReceptor': timestampReceptor,
    };
  }
}
