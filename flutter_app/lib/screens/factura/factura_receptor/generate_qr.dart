import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_header.dart';
import 'package:flutter_app/widgets/account/account_summary_card.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/account/type_account_symb.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrScreen extends StatefulWidget {
  static const String routeName = generateQrRouteName;

  const GenerateQrScreen({super.key});

  @override
  State<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends State<GenerateQrScreen> {
  List<Account>? accounts;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    final providerManager = Provider.of<ProviderManager>(context);
    accounts = providerManager.myAccounts;
    super.didChangeDependencies();
  }

  List<Account> getFilteredAccounts(bool isShared) {
    if (accounts == null) return [];
    return accounts!.where((acc) => acc.esCompartida == isShared).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione una cuenta'),
      ),
      body: accounts == null || isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const TypeAccountSymb(),
                Expanded(
                  child: getFilteredAccounts(false).isNotEmpty
                      ? ListView.builder(
                          itemCount: getFilteredAccounts(false).length,
                          itemBuilder: (BuildContext context, int index) {
                            final acc = getFilteredAccounts(false)[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _showAccountQr(acc);
                                },
                                child: AccountSummaryCard(account: acc),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No cuenta con cuentas propias.',
                              style: TextStyle(color: Colors.red))),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Text(
                    'Cuentas compartidas conmigo:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: getFilteredAccounts(true).isNotEmpty
                      ? ListView.builder(
                          itemCount: getFilteredAccounts(true).length,
                          itemBuilder: (BuildContext context, int index) {
                            final acc = getFilteredAccounts(true)[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _showAccountQr(acc);
                                },
                                child: AccountSummaryCard(account: acc),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No cuenta con cuentas compartidas.',
                              style: TextStyle(color: Colors.red))),
                ),
              ],
            ),
    );
  }

  void _setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  void _showAccountQr(Account account) async {
    try {
      _setLoadingTrue();

      var accountEncryptedCode =
          await getAccountBillingQr(int.parse(account.id));
      var receptorModelName = await getDeviceModel();
      var receptorLocation = await getLocation();
      var receptorTimeStamp = DateTime.now().toIso8601String();
      String codigoQr =
          '$accountEncryptedCode $receptorModelName ${receptorLocation[0]} ${receptorLocation[1]} $receptorTimeStamp';

      _setLoadingFalse();

      if (context.mounted) {
        _openQrAlertModal(context, account, codigoQr);
      }
    } catch (e) {
      _setLoadingFalse();
      if (context.mounted) {
        showAlertDialog(context, 'A ocurrido un error', e.toString(), 'Ok');
      }
    }
  }

  void _openQrAlertModal(
      BuildContext context, Account account, String codigoQr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(8),
                          color: account.cedulaTipo == 'Juridica'
                              ? const Color.fromARGB(255, 180, 193, 255)
                              : const Color.fromARGB(255, 180, 234, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AccountInfoCardHeader(
                              cedulaTipo: account.cedulaTipo,
                              cedulaNumero: account.cedulaNumero,
                              nombre: account.nombre,
                              alias: account.alias,
                            ),
                          )),
                      const SizedBox(height: 20),
                      const MyText(
                        text: 'Código QR generado',
                        fontSize: 24,
                      ),
                      if (codigoQr.isNotEmpty) ...[
                        const SizedBox(height: 26),
                        Center(
                          child: QrImage(
                            data: codigoQr,
                            version: QrVersions.auto,
                            size: 200,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const MyText(
                        text: 'Tiempo de expiración: 1 minuto',
                        fontSize: 18,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
