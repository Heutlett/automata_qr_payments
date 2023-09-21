import 'package:flutter/material.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:provider/provider.dart';

class AccountInfoCardSharedAcc extends StatefulWidget {
  const AccountInfoCardSharedAcc({
    super.key,
    required this.account,
  });
  final Account account;

  @override
  State<AccountInfoCardSharedAcc> createState() =>
      _AccountInfoCardSharedAccState();
}

class _AccountInfoCardSharedAccState extends State<AccountInfoCardSharedAcc> {
  late Account acc;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    acc = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              acc.usuariosCompartidos.isNotEmpty
                  ? Card(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  text: 'Usuarios con esta cuenta compartida:',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Column(
                              children: acc.usuariosCompartidos.map((user) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                            text: user.nombreCompleto,
                                            fontSize: 13,
                                          ),
                                          ElevatedButton(
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.red)),
                                              onPressed: () {
                                                _deleteUserAcc(
                                                    context,
                                                    acc.id,
                                                    user.username,
                                                    providerManager);
                                              },
                                              child: const Icon(
                                                  Icons.unpublished_outlined))
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
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

  void _deleteUserAcc(BuildContext context, String accountId, String username,
      ProviderManager providerManager) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea dejar de compartir la cuenta con $username?',
        'Si, acepto',
        'No, cancelar', () {
      _deleteUserAccConfirm(context, accountId, username, providerManager);
    });
  }

  void _deleteUserAccConfirm(BuildContext context, String accountId,
      String username, ProviderManager providerManager) async {
    _setLoadingTrue();
    var response = await unshareUserAccount(accountId, username);
    _setLoadingFalse();

    if (response.success) {
      _setLoadingTrue();
      var loadedAccounts = await getAccountList();
      _setLoadingFalse();

      if (context.mounted) {
        providerManager.reloadAccountsInAccountManagement(
            context, loadedAccounts);
      }
    } else {
      if (context.mounted) {
        showAlertDialog(context, 'Error', response.message, 'Aceptar');
      }
    }
  }
}
