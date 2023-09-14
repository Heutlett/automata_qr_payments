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
  List<ComprobanteSummary>? _listComprobantesSummary;
  final Map<int, String> _accountsIds = {};

  @override
  void didChangeDependencies() {
    final providerManager = Provider.of<ProviderManager>(context);

    setAccountIds(providerManager);
    setComprobantesSummary();
    _selectedAccount = _accountsIds.keys.first;

    super.didChangeDependencies();
  }

  void setAccountIds(ProviderManager providerManager) {
    for (int i = 0; i < providerManager.myAccounts.length; i++) {
      _accountsIds[int.parse(providerManager.myAccounts[i].id)] =
          providerManager.myAccounts[i].nombre;
    }
  }

  Future<void> setComprobantesSummary() async {
    ServerResponse<List<ComprobanteSummary>> response =
        await getComprobantesSummary(_accountsIds.keys.first);

    setState(() {
      _listComprobantesSummary = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de pagos'),
      ),
      body: _listComprobantesSummary == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                            items: _accountsIds.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value,
                                    style: const TextStyle(fontSize: 15)),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedAccount = newValue;
                                _listComprobantesSummary = null;
                                updateRecordsAccount(
                                    context, _selectedAccount!);
                              });
                            },
                          )
                        ]),
                  ),
                  _listComprobantesSummary == null
                      ? const CircularProgressIndicator() // Indicador de carga
                      : Expanded(
                          child: _listComprobantesSummary!.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: MyText(
                                    text: "El historial está vacio",
                                    color: Colors.red,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _listComprobantesSummary!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ComprobanteSummary comprobante =
                                        _listComprobantesSummary![index];

                                    return HistoryCard(
                                      id: comprobante.id,
                                      estado: comprobante.estado,
                                      descripcion: comprobante.descripcion,
                                      fechaEmision: comprobante.fechaEmision,
                                      codigoMonedaId:
                                          comprobante.codigoMonedaId,
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
            ),
    );
  }

  void updateRecordsAccount(BuildContext context, int accountId) async {
    ServerResponse<List<ComprobanteSummary>> response =
        await getComprobantesSummary(accountId);

    if (context.mounted) {
      if (response.success) {
        setState(() {
          _listComprobantesSummary = response.data!;
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
