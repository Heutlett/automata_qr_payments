import 'package:flutter/material.dart';
import 'package:flutter_app/models/comprobante.dart';
import 'package:flutter_app/services/factura/factura_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatelessWidget {
  final int id;
  final String estado;
  final String descripcion;
  final String numeroConsecutivo;
  final DateTime fechaEmision;
  final int codigoMonedaId;
  final double totalComprobante;

  final Map<int, String> codigosMoneda = {
    56: "₡",
    250: "\$",
  };

  RecordCard({
    super.key,
    required this.id,
    required this.estado,
    required this.descripcion,
    required this.numeroConsecutivo,
    required this.fechaEmision,
    required this.codigoMonedaId,
    required this.totalComprobante,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openBottomSheet(context, id);
      },
      child: Card(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 182, 182, 182),
                child: Row(
                  children: [
                    Text("  # $numeroConsecutivo"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(fechaEmision.toLocal()),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(estado),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(descripcion),
                        Text(
                          " ${codigosMoneda[codigoMonedaId]} ${totalComprobante.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: totalComprobante >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context, int comprobanteId) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 800,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RecordModal(comprobanteId: comprobanteId);
            },
          ),
        );
      },
    );
  }
}

class RecordModal extends StatefulWidget {
  final int comprobanteId;

  const RecordModal({
    super.key,
    required this.comprobanteId,
  });

  @override
  State<RecordModal> createState() => _RecordModalState();
}

class _RecordModalState extends State<RecordModal> {
  Comprobante? comprobante;

  Future<Comprobante?> _getComprobante(
      BuildContext context, int comprobanteId) async {
    var response = await getComprobante(comprobanteId);

    if (response.success) {
      var comprobante = response.data;
      return comprobante;
    } else {
      if (context.mounted) {
        showAlertDialog(
            context, "Error", "No se ha encontrado el comprobante", "Aceptar");
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    setComprobante();
  }

  void setComprobante() async {
    var request = await _getComprobante(context, widget.comprobanteId);
    setState(() {
      comprobante = request;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: comprobante == null
            ? const Center(child: const CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: const Color.fromARGB(255, 222, 219, 219),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(comprobante!.clave,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RecordField(
                        name: 'Número Consecutivo',
                        value: comprobante!.numeroConsecutivo),
                    RecordField(
                        name: "Fecha de Emisión:",
                        value: DateFormat('dd/MM/yyyy HH:mm')
                            .format(comprobante!.fechaEmision.toLocal())),
                    RecordField(
                        name: "Cuenta Emisor:",
                        value: comprobante!.cuentaEmisor.nombre),
                    RecordField(
                        name: "Cuenta Receptor:",
                        value: comprobante!.cuentaReceptor.nombre),
                    RecordField(
                        name: "Descripción:", value: comprobante!.descripcion),
                    RecordField(name: "Estado:", value: comprobante!.estado),
                    RecordField(
                        name: "Código de Actividad:",
                        value: comprobante!.codigoActividad),
                    RecordField(
                        name: "Condición de Venta:",
                        value: comprobante!.condicionVenta),
                    RecordField(
                        name: "Medio de Pago:", value: comprobante!.medioPago),
                    RecordField(
                        name: "Código de Moneda:",
                        value: comprobante!.codigoMoneda),
                    RecordField(
                        name: "Total de Venta:",
                        value: comprobante!.totalVenta.toStringAsFixed(2)),
                    RecordField(
                        name: "Total de Descuentos:",
                        value: comprobante!.totalDescuentos.toStringAsFixed(2)),
                    RecordField(
                        name: "Total de Impuesto:",
                        value: comprobante!.totalImpuesto.toStringAsFixed(2)),
                    RecordField(
                        name: "Total del Comprobante:",
                        value:
                            comprobante!.totalComprobante.toStringAsFixed(2)),
                  ],
                ),
              ));
  }
}

class RecordField extends StatelessWidget {
  final String name;
  final String value;

  const RecordField({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
