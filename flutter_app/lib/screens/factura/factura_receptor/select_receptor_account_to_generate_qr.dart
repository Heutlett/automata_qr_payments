import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_summary_card.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SelectReceptorAccountToGenerateQrScreen extends StatefulWidget {
  static const String routeName = selectReceptorAccountToGenerateQrRouteName;

  const SelectReceptorAccountToGenerateQrScreen({Key? key});

  @override
  State<SelectReceptorAccountToGenerateQrScreen> createState() =>
      _SelectReceptorAccountToGenerateQrScreenState();
}

class _SelectReceptorAccountToGenerateQrScreenState
    extends State<SelectReceptorAccountToGenerateQrScreen> {
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
        title: const Text('Seleccione su cuenta receptor'),
      ),
      body: accounts == null || isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16),
                          child: Text(
                            'Cuentas propias:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    const SizedBox(width: 10),
                                    CircleWidget(
                                        radius: 7,
                                        color: const Color.fromARGB(
                                            255, 190, 237, 255)),
                                    const SizedBox(width: 15),
                                    const Text('Física'),
                                    const SizedBox(width: 10),
                                  ]),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Ajusta el radio para controlar la redondez de las esquinas
                                  side: const BorderSide(
                                      color: Colors.black,
                                      width:
                                          1.0), // Añade un borde negro de 1 píxel
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    const SizedBox(width: 10),
                                    CircleWidget(
                                        radius: 7,
                                        color: const Color.fromARGB(
                                            255, 190, 201, 255)),
                                    const SizedBox(width: 15),
                                    const Text('Jurídica'),
                                    const SizedBox(width: 10),
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: getFilteredAccounts(false).map((acc) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _showGenerateQrScreen(context, acc);
                            },
                            child: AccountSummaryCard(account: acc),
                          ),
                        );
                      }).toList(),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                      child: Text(
                        'Cuentas compartidas conmigo:',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: getFilteredAccounts(true).map((acc) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _showGenerateQrScreen(context, acc);
                            },
                            child: AccountSummaryCard(account: acc),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
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

  void _showGenerateQrScreen(BuildContext context, Account account) async {
    _setLoadingTrue();
    var accountEncryptedCode = await getAccountBillingQr(int.parse(account.id));
    var receptorModelName = await getDeviceModel();
    var receptorLocation = await getLocation();
    _setLoadingFalse();
    var receptorTimeStamp = DateTime.now().toIso8601String();

    String codigoQr =
        '$accountEncryptedCode $receptorModelName ${receptorLocation[0]} ${receptorLocation[1]} $receptorTimeStamp';

    var args = [
      account.cedulaTipo,
      account.cedulaNumero,
      account.nombre,
      codigoQr,
    ];

    if (context.mounted) {
      Navigator.of(context).pushNamed(showReceptorQrRouteName, arguments: args);
    }
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;
  final Color color;

  CircleWidget({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
