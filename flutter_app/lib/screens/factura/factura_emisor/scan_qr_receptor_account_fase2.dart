import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_card.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_app/services/account/account_service.dart';

import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class ScanQrReceptorAccountScreen extends StatefulWidget {
  static const String routeName = scanQrReceptorAccountRouteName;

  const ScanQrReceptorAccountScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrReceptorAccountScreen> createState() =>
      _ScanQrReceptorAccountScreenState();
}

class _ScanQrReceptorAccountScreenState
    extends State<ScanQrReceptorAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final Account accountEmisor =
        ModalRoute.of(context)?.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de cuentas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const MyText(
              text: 'Cuenta emisor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5,
              color: accountEmisor.cedulaTipo == 'Juridica'
                  ? const Color.fromARGB(255, 180, 193, 255)
                  : const Color.fromARGB(255, 180, 234, 255),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AccountInfoCard(
                  account: accountEmisor,
                  addButtons: 1,
                  showIsShared: true,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const MyText(
              text: 'Cuenta receptor',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Escanear QR de receptor',
              function: () => scanQR(context),
              icon: Icons.qr_code_scanner,
              backgroundColor: Colors.green,
              size: const Size(290, 50),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAccounts(Account emisorAccount, Account receptorAccount) {
    return emisorAccount.id == receptorAccount.id ? false : true;
  }

  void showSelectAccountManagement(
      BuildContext context, String codigoQr) async {
    List<String> codigoQrParts = codigoQr.split(" ");
    var accountEncryptedCode = codigoQrParts[0];
    var receptorModelName = codigoQrParts[1];
    List<double> receptorLocation = [
      double.parse(codigoQrParts[2]),
      double.parse(codigoQrParts[3]),
    ];
    String receptorTimeStamp = codigoQrParts[4];

    ServerResponse<Account?> getCuenta =
        await getCuentaByQr(accountEncryptedCode);

    Account? receptorAccount = getCuenta.data;

    final Account emisorAccount =
        ModalRoute.of(context)?.settings.arguments as Account;

    if (context.mounted) {
      if (receptorAccount == null || !getCuenta.success) {
        showAlertDialog(context, 'Error', getCuenta.message, 'Ok');
      } else {
        List<Account> cuentas = [
          emisorAccount,
          receptorAccount,
        ];

        if (validateAccounts(emisorAccount, receptorAccount)) {
          Navigator.of(context).pushNamed(
            showSelectedAccountsRouteName,
            arguments: [
              cuentas,
              receptorModelName,
              receptorLocation,
              receptorTimeStamp,
            ],
          );
        } else {
          showAlertDialog(
            context,
            'Error',
            'La cuenta escaneada es la misma cuenta seleccionada como emisor, esto no es posible',
            'Aceptar',
          );
        }
      }
    }
  }

  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (context.mounted) {
        showSelectAccountManagement(context, barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
