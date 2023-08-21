import 'package:flutter/material.dart';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/screens/widgets/records/record_card.dart';
import 'package:flutter_app/utils/utils.dart';

import '../../models/server_response.dart';
import '../../services/factura/factura_service.dart';
import '../widgets/general/my_text.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  int? _selectedAccount;

  List<ComprobanteSummary>? data = [];

  Map<int, String> accountsIds = {};

  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      List<dynamic> args =
          ModalRoute.of(context)?.settings.arguments as List<dynamic>;

      accountsIds = args[0];
      data = args[1];

      _selectedAccount = accountsIds.keys.first;

      isInitialized = true;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Historial de pagos'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Seleccione la cuenta:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField<int>(
                        value: _selectedAccount,
                        items: accountsIds.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key,
                            child: Text(entry.value,
                                style: const TextStyle(fontSize: 15)),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedAccount = newValue;
                            data = null;
                            updateRecordsAccount(context, _selectedAccount!);
                          });
                        },
                      )
                    ]),
              ),
              data == null
                  ? const CircularProgressIndicator() // Indicador de carga
                  : Expanded(
                      child: data!.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MyText(
                                text: "El historial está vacio",
                                color: Colors.red,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                ComprobanteSummary comprobante = data![index];

                                return RecordCard(
                                  estado: comprobante.estado,
                                  descripcion: comprobante.descripcion,
                                  fechaEmision: comprobante.fechaEmision,
                                  codigoMonedaId: comprobante.codigoMonedaId,
                                  numeroConsecutivo:
                                      comprobante.numeroConsecutivo,
                                  totalComprobante:
                                      comprobante.totalComprobante,
                                );
                              },
                            ),
                    ),
            ],
          ),
        ));
  }

  void updateRecordsAccount(BuildContext context, int accountId) async {
    ServerResponse<List<ComprobanteSummary>> response =
        await getComprobanteSummary(accountId);

    if (context.mounted) {
      if (response.success) {
        setState(() {
          data = response.data!;
        });
      } else {
        showAlertDialog(
            context, "Error", "No se ha encontrado la cuenta", "Aceptar");
      }
    }
  }
}
