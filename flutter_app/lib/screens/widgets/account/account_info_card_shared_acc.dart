import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/general/my_button.dart';
import 'package:flutter_app/screens/widgets/general/my_text.dart';

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
                                      text: user,
                                      fontSize: 13,
                                    ),
                                    MyButton(
                                      text: 'Eliminar usuario',
                                      function: deleteUser,
                                      fontSize: 13,
                                      size: const Size(130, 20),
                                      backgroundColor: Colors.red,
                                    ),
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

  void deleteUser() {}
}
