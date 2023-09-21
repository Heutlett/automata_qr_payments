import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
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
      body: Consumer<ProviderManager>(
        builder: (context, provider, child) {
          final accounts = provider.myAccounts;

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Card(
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
              );
            },
          );
        },
      ),
    );
  }

  void _showCreateAccountScreen(BuildContext context) async {
    Navigator.of(context).pushNamed(createAccountRouteName);
  }

  void _showAddSharedAccountScreen(BuildContext context) async {
    Navigator.of(context).pushNamed(addSharedAccountRouteName);
  }
}
