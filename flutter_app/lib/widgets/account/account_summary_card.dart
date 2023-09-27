import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';

class AccountSummaryCard extends StatefulWidget {
  final Account account;

  const AccountSummaryCard({
    super.key,
    required this.account,
  });

  @override
  State<AccountSummaryCard> createState() => _AccountSummaryCardState();
}

class _AccountSummaryCardState extends State<AccountSummaryCard> {
  late Account account;

  @override
  void initState() {
    super.initState();
    account = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: account.cedulaTipo == 'Juridica'
          ? const Color.fromARGB(255, 190, 201, 255)
          : const Color.fromARGB(255, 190, 237, 255),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 70,
                child: Text(
                  account.alias,
                  style: const TextStyle(fontSize: 12),
                )),
            const SizedBox(
              height: 25,
              width: 5,
              child: VerticalDivider(
                  thickness: 1, color: Color.fromARGB(67, 0, 0, 0)),
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      account.cedulaNumero,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            const SizedBox(
              height: 25,
              width: 5,
              child: VerticalDivider(
                thickness: 1,
                color: Color.fromARGB(67, 0, 0, 0),
              ),
            ),
            SizedBox(
                width: 160,
                child: Text(
                  account.nombre.length <= 20
                      ? account.nombre
                      : '${account.nombre.substring(0, 19)}...',
                  style: const TextStyle(fontSize: 12),
                )),
          ],
        ),
      ),
    );
  }
}
