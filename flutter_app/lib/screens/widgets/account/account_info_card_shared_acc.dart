import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

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

  @override
  void initState() {
    super.initState();
    acc = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                      MainAxisAlignment.spaceAround,
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
                                          deleteUserAcc(
                                              context, acc.id, user.username);
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

  void deleteUserAcc(
      BuildContext context, String accountId, String username) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea dejar de compartir la cuenta con $username?',
        'Si, acepto',
        'No, cancelar', () {
      deleteUserAccConfirm(context, accountId, username);
    });
  }

  void deleteUserAccConfirm(
      BuildContext context, String accountId, String username) async {
    var deleteResponse = await unshareUserAccount(accountId, username);
    if (context.mounted) {
      if (deleteResponse.success) {
        showAlertDialog(
            context,
            'Usuario eliminado',
            'La cuenta se ha dejado de compartir con $username correctamente.',
            'Aceptar');
      } else {
        showAlertDialog(context, 'Error', deleteResponse.message, 'Aceptar');
      }
    }
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/home_logged", (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed('/account_management');
    }
  }
}
