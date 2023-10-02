import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/account/account_summary_card.dart';
import 'package:flutter_app/widgets/general/my_back_button.dart';
import 'package:provider/provider.dart';

class AccountManagementScreen extends StatefulWidget {
  static const String routeName = accountManagementRouteName;

  const AccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  List<Account>? accounts;

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
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(routeName: homeLoggedRouteName),
            ElevatedButton(
              onPressed: () {
                _showCreateAccountScreen(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('Cuenta'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showAddSharedAccountScreen(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple)),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('Cuenta compartida'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: accounts == null
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(children: [
                                SizedBox(width: 10),
                                CircleWidget(
                                    radius: 7,
                                    color: Color.fromARGB(255, 190, 237, 255)),
                                SizedBox(width: 15),
                                Text('Física'),
                                SizedBox(width: 10),
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(children: [
                                SizedBox(width: 10),
                                CircleWidget(
                                    radius: 7,
                                    color: Color.fromARGB(255, 190, 201, 255)),
                                SizedBox(width: 15),
                                Text('Jurídica'),
                                SizedBox(width: 10),
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
                            _openAlertModal(context, acc);
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

  void _openAlertModal(BuildContext context, Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 5,
                      color: account.cedulaTipo == 'Juridica'
                          ? const Color.fromARGB(255, 180, 193, 255)
                          : const Color.fromARGB(255, 180, 234, 255),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            AccountInfoCard(
                              account: account,
                              addButtons: 2,
                              showIsShared: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showCreateAccountScreen(BuildContext context) async {
    Navigator.of(context).pushNamed(createAccountRouteName);
  }

  void _showAddSharedAccountScreen(BuildContext context) async {
    Navigator.of(context).pushNamed(addSharedAccountRouteName);
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const CircleWidget({super.key, required this.radius, required this.color});

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
