import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/account/account_summary_card.dart';
import 'package:flutter_app/widgets/account/type_account_symb.dart';
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackButton(routeName: homeLoggedRouteName),
            Text('Administración de cuentas'),
            SizedBox()
          ],
        ),
      ),
      body: accounts == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showCreateAccountScreen(context);
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              Text('Cuenta'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showAddSharedAccountScreen(context);
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple)),
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              Text('Cuenta compartida'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(thickness: 1),
                ),
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
                                  _openAccountManagementAlertModal(
                                      context, acc);
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
                                  _openAccountManagementAlertModal(
                                      context, acc);
                                },
                                child: AccountSummaryCard(account: acc),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No cuenta con cuentas compartidas.',
                              style: TextStyle(color: Colors.red))),
                )
              ],
            ),
    );
  }

  void _openAccountManagementAlertModal(BuildContext context, Account account) {
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
