import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_header.dart';
import 'package:flutter_app/widgets/account/account_summary_card.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/utils/utils.dart';
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
  List<String>? args;
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: getFilteredAccounts(false).length,
                    itemBuilder: (BuildContext context, int index) {
                      final acc = getFilteredAccounts(false)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _setQrArgs(acc);
                          },
                          child: AccountSummaryCard(account: acc),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Text(
                    'Cuentas compartidas conmigo:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: getFilteredAccounts(true).length,
                    itemBuilder: (BuildContext context, int index) {
                      final acc = getFilteredAccounts(true)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _setQrArgs(acc);
                            _openAlertModal(context, acc);
                          },
                          child: AccountSummaryCard(account: acc),
                        ),
                      );
                    },
                  ),
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

  void _setQrArgs(Account account) async {
    _setLoadingTrue();
    var accountEncryptedCode = await getAccountBillingQr(int.parse(account.id));
    var receptorModelName = await getDeviceModel();
    var receptorLocation = await getLocation();
    var receptorTimeStamp = DateTime.now().toIso8601String();

    String codigoQr =
        '$accountEncryptedCode $receptorModelName ${receptorLocation[0]} ${receptorLocation[1]} $receptorTimeStamp';

    setState(() {
      args = [
        account.cedulaTipo,
        account.cedulaNumero,
        account.nombre,
        account.alias,
        codigoQr,
      ];
    });

    _setLoadingFalse();

    if (context.mounted) {
      _openAlertModal(context, account);
    }
  }

  void _openAlertModal(BuildContext context, Account account) {
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
                          color: args![0] == 'Juridica'
                              ? const Color.fromARGB(255, 180, 193, 255)
                              : const Color.fromARGB(255, 180, 234, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AccountInfoCardHeader(
                              cedulaTipo: args![0],
                              cedulaNumero: args![1],
                              nombre: args![2],
                              alias: args![3],
                            ),
                          )),
                      const SizedBox(height: 20),
                      const MyText(
                        text: 'Código QR generado',
                        fontSize: 24,
                      ),
                      if (args![4].isNotEmpty) ...[
                        const SizedBox(height: 26),
                        Center(
                          child: QrImage(
                            data: args![4],
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
