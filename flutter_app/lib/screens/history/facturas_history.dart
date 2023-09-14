import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/widgets/history/history_card.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../models/server_response.dart';
import '../../services/factura/factura_service.dart';
import '../../widgets/general/my_text.dart';

class FacturasHistoryScreen extends StatefulWidget {
  static const String routeName = facturasHistoryRouteName;

  const FacturasHistoryScreen({Key? key}) : super(key: key);

  @override
  State<FacturasHistoryScreen> createState() => _FacturasHistoryScreenState();
}

class _FacturasHistoryScreenState extends State<FacturasHistoryScreen> {
  int? _selectedAccount;

  List<ComprobanteSummary>? data = [];

  Map<int, String> accountsIds = {};

  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void setAccountIds(ProviderManager providerManager) {
    for (int i = 0; i < providerManager.myAccounts.length; i++) {
      accountsIds[int.parse(providerManager.myAccounts[i].id)] =
          providerManager.myAccounts[i].nombre;
    }
  }

  Future<void> setComprobantesSummary() async {}

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    setAccountIds(providerManager);

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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                id: comprobante.id,
                                estado: comprobante.estado,
                                descripcion: comprobante.descripcion,
                                fechaEmision: comprobante.fechaEmision,
                                codigoMonedaId: comprobante.codigoMonedaId,
                                numeroConsecutivo:
                                    comprobante.numeroConsecutivo,
                                totalComprobante: comprobante.totalComprobante,
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  void updateRecordsAccount(BuildContext context, int accountId) async {
    ServerResponse<List<ComprobanteSummary>> response =
        await getComprobantesSummary(accountId);

    if (context.mounted) {
      if (response.success) {
        setState(() {
          data = response.data!;
        });
      } else {
        showAlertDialog(
          context,
          "Error",
          "No se ha encontrado la cuenta",
          "Aceptar",
        );
      }
    }
  }
}