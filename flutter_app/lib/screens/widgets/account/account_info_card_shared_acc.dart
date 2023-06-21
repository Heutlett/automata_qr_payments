import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Account acc = widget.account;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: 'Información cuentas compartidas:',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            MyText(
              text: 'Esta cuenta es compartida',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
