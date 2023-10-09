import 'package:flutter/material.dart';
import 'package:flutter_app/models/comprobante.dart';
import 'package:flutter_app/services/factura/factura_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:intl/intl.dart';

class HistoryDetailsModal extends StatefulWidget {
  final int comprobanteId;

  const HistoryDetailsModal({
    super.key,
    required this.comprobanteId,
  });

  @override
  State<HistoryDetailsModal> createState() => _HistoryDetailsModalState();
}

class _HistoryDetailsModalState extends State<HistoryDetailsModal> {
  Comprobante? _comprobante;

  @override
  void initState() {
    _loadComprobante(context);
    super.initState();
  }

  void _loadComprobante(BuildContext context) async {
    var response = await getComprobante(widget.comprobanteId);

    if (response.success) {
      setState(() {
        _comprobante = response.data;
      });
    } else {
      if (context.mounted) {
        showAlertDialog(
            context, "Error", "No se ha encontrado el comprobante", "Aceptar");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _comprobante == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                color: const Color.fromARGB(255, 222, 219, 219),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(_comprobante!.numeroConsecutivo,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.clear))
                          ],
                        ),
                        const SizedBox(height: 8),
                        RecordField(
                            name: 'Número Consecutivo',
                            value: _comprobante!.numeroConsecutivo),
                        RecordField(
                            name: "Fecha de Emisión:",
                            value: DateFormat('dd/MM/yyyy HH:mm')
                                .format(_comprobante!.fechaEmision.toLocal())),
                        RecordField(
                            name: "Cuenta Emisor:",
                            value: _comprobante!.cuentaEmisor.nombre),
                        RecordField(
                            name: "Cuenta Receptor:",
                            value: _comprobante!.cuentaReceptor.nombre),
                        RecordField(
                            name: "Descripción:",
                            value: _comprobante!.descripcion),
                        RecordField(
                            name: "Estado:", value: _comprobante!.estado),
                        RecordField(
                            name: "Código de Actividad:",
                            value: _comprobante!.codigoActividad),
                        RecordField(
                            name: "Condición de Venta:",
                            value: _comprobante!.condicionVenta),
                        RecordField(
                            name: "Medio de Pago:",
                            value: _comprobante!.medioPago),
                        RecordField(
                            name: "Código de Moneda:",
                            value: _comprobante!.codigoMoneda),
                        const SizedBox(height: 20),
                        RecordField(
                            name: 'Dispositivo Emisor',
                            value: _comprobante!
                                .detalleComprobante.dispositivoEmisor),
                        RecordField(
                            name: 'latitudEmisor',
                            value: _comprobante!
                                .detalleComprobante.latitudEmisor
                                .toString()),
                        RecordField(
                            name: 'longitudEmisor',
                            value: _comprobante!
                                .detalleComprobante.longitudEmisor
                                .toString()),
                        RecordField(
                            name: 'timestampEmisor',
                            value: _comprobante!
                                .detalleComprobante.timestampEmisor
                                .toString()),
                        RecordField(
                            name: 'Dispositivo Receptor',
                            value: _comprobante!
                                .detalleComprobante.dispositivoEmisor),
                        RecordField(
                            name: 'latitudReceptor',
                            value: _comprobante!
                                .detalleComprobante.latitudReceptor
                                .toString()),
                        RecordField(
                            name: 'longitudReceptor',
                            value: _comprobante!
                                .detalleComprobante.longitudReceptor
                                .toString()),
                        RecordField(
                            name: 'timestampReceptor',
                            value: _comprobante!
                                .detalleComprobante.timestampReceptor
                                .toIso8601String()),
                        const SizedBox(height: 20),
                        Text("Lista productos o servicios:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Center(
                          child: Text(
                            "En desarrollo",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RecordField(
                            name: "Total de Venta:",
                            value: _comprobante!.totalVenta.toStringAsFixed(2)),
                        RecordField(
                            name: "Total de Descuentos:",
                            value: _comprobante!.totalDescuentos
                                .toStringAsFixed(2)),
                        RecordField(
                            name: "Total de Impuesto:",
                            value:
                                _comprobante!.totalImpuesto.toStringAsFixed(2)),
                        RecordField(
                            name: "Total del Comprobante:",
                            value: _comprobante!.totalComprobante
                                .toStringAsFixed(2)),
                      ],
                    ),
                  ),
                ],
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
